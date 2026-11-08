# Live HTML

A **live page** is one HTML file that computes its numbers, figures and tables in the reader's browser when it opens, from data and Python code carried inside the file. It runs standalone: opened straight from disk, with internet access for the runtimes, no server. The study dashboard is a live page, and so is any probe page that needs interaction (a 3D structure, a table to filter).

The layout is free: choose sections, order and look for what the result needs. The patterns below are not free.

If the harness offers a dedicated live-page skill for the domain (for chemistry, `chem-live-html`), call it for the page; these patterns still hold.

## Patterns

1. **Python in the page.** Load Pyodide from a CDN and run the analysis in Python. The data sits in `<script type="application/json" id="data">`, the code in `<script type="text/x-python" id="py-analysis">`. On load, one function runs: `analyze(data) -> {stats, figures, tables}`, returning plain JSON. JavaScript only renders what comes back. Reuse the probe's own analysis code, so the page and the probe cannot disagree. Load only the packages the code imports (`numpy` by default).
2. **No typed numbers.** Every number in the prose is a `<span data-stat="key">` filled from `stats`. A key the analysis did not return renders visibly as missing, never as blank.
3. **Figures are data.** Python returns Plotly specs as JSON, and the page draws them with Plotly.js. The figure rules in [RESULTS.md](RESULTS.md) apply unchanged.
4. **Adjustable text size.** A control in the page sets a `--scale` CSS variable, and every font size is written as `calc(<N>px * var(--scale))`, chart text included. Remember the choice in `localStorage`, with every read and write in `try`/`catch`, so the page still works when storage is blocked.
5. **Code in view.** Show the data and the Python in collapsible panels, so the reader sees what computed each number.
6. **Pinned runtimes.** Every CDN URL names an exact version.
7. **No web workers.** Some places that display pages (an artifact viewer, a sandboxed preview) block workers built from `blob:` URLs, and the page then dies with `SecurityError: Failed to construct 'Worker'`. Run everything on the main thread: Pyodide loaded with `loadPyodide()` in the page already does; 3Dmol.js needs `$3Dmol.setSyncSurface(true)` before any surface is added, because its surfaces are computed in workers by default.
8. **Ready or failed, visibly.** Show a loading status while the runtimes load. When everything has rendered, set `<html data-ready="true">`. On any error, show the error in the page instead of a half-rendered result.

## Molecular structures

When the study works on molecules, show them with **3Dmol.js** (pinned version), with this styling:

- **Protein:** cartoon, plus a molecular surface that is **transparent** (opacity about 0.25), so the cartoon and the ligand show through it.
- **Ligand, or any selection the view is centred on:** sticks, with a carbon colour distinct from the protein's.
- **Residues within 5 Å of the selection:** lines, labelled with residue name and number on hover.
- **View:** zoom to the selection and its 5 Å shell, not to the whole structure.

```js
$3Dmol.setSyncSurface(true);                       // surfaces on the main thread, no workers
const v = $3Dmol.createViewer(el, { backgroundColor: "white" });
v.addModel(pdbText, "pdb");
const lig = { resn: "LIG" };                       // the centred selection
v.setStyle({}, { cartoon: { color: "spectrum" } });
v.setStyle(lig, { stick: { colorscheme: "greenCarbon" } });
v.setStyle({ within: { distance: 5, sel: lig }, byres: true, not: lig },
           { line: {}, cartoon: { color: "spectrum" } });
v.addSurface($3Dmol.SurfaceType.VDW, { opacity: 0.25, color: "white" }, { not: lig });
v.zoomTo({ within: { distance: 5, sel: lig }, byres: true }); v.render();
```

Carry the structure in the page (PDB or SDF text in a `<script>` block) or fetch it from the primary database by a pinned identifier, and say which in the page. Create a viewer only when it scrolls into view, and resize it when the layout or the text size changes.

## Smoke test

Before showing a live page to the user, open it from disk in a headless browser and check:

- `html[data-ready="true"]` appears, and the console shows no errors;
- no `data-stat` is missing, and every Plotly figure and 3Dmol viewer has drawn;
- raising the text size makes the body and chart text larger, and the choice survives a reload;
- at phone width, the page has no horizontal scroll;
- with `window.Worker` replaced by a function that throws (inject it before any other script), the page still reaches `data-ready`.

Done when every check passes.
