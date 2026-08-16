# Add Sub.Mission event — design note

Date: 2026-08-16

Summary
-------
Add "Sub.Mission Electronic Tuesdays DJ Battle" (Sept 15th, doors 8pm) as a show entry in the events list and include the flyer image.

Placement and format
--------------------
- Follow existing show-card pattern in `src/events/index.html` (hidden `#all-events` list used by JS on the homepage).
- Visible copy omits the year (matches existing items); `data-date` includes the year for sorting.

Files changed
-------------
- `src/events/index.html` — new show-card anchor added at top of `#all-events`.
- `dist/images/shows/blackbox-battle-sept26.jpg` — flyer image added.

Markup (insertion)
------------------
<a href="https://blackboxdenver.co/events/etuesdays-sep15/ticket" target="_blank" class="show-card" data-date="2026-09-15">
    <img src="../images/shows/blackbox-battle-sept26.jpg" alt="Sub.Mission Electronic Tuesdays DJ Battle">
    <div class="show-info">
        <h3>Sub.Mission Electronic Tuesdays DJ Battle</h3>
        <p>Sept 15th @ 8pm - The Black Box, Denver</p>
    </div>
</a>

Why this approach
------------------
- Keeps event list consistent and allows the homepage script to auto-select the next upcoming event.
- Avoids temporarily replacing the homepage highlight; less risk of visual regressions.

Deployment & verification
-------------------------
- Build: `make build`
- Deploy: GitHub Actions deploys on push to `main` (already configured).
- Verify: visit https://lushreds.com and confirm the flyer loads and the event appears in the events page. If a 404 is served, invalidate CDN cache for the path or run `gcloud auth` and use `gcloud compute url-maps invalidate-cdn-cache`.

Rollback
--------
Revert the two commits (events file and image) or remove the anchor and image and push.

Notes
-----
This change was applied after user approval and committed to `main`.

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
