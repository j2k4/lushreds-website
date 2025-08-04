# Lushreds QR Redirect & Analytics Tracking

This document describes the setup, tracking logic, and how to monitor performance of the `go.lushreds.com` QR redirect system using Google Analytics 4 (GA4).

---

## 🔁 Redirect Service (Cloud Run)

**Domain:** https://go.lushreds.com  
**Hosted on:** Google Cloud Run  
**Source code location:** GitHub repo (TBD)

### How it works

- The redirect service accepts a query parameter `?c=CODE`
- It maps the code to a destination URL in `configMap`
- If the code exists, it performs a 302 redirect to the mapped URL
- If the code is missing or invalid, it redirects to https://lushreds.com

### Example configMap
```js
const configMap = {
  "SNACKS": "https://lushreds.com/?utm_source=qr&utm_medium=card&utm_campaign=SNACKS",
  "SOCIAL": "https://instagram.com/lushreds",
  "STREAM": "https://open.spotify.com/artist/6NcZzdLXWxAUZMvEgVhIx2?si=U-Hi9jJoQTuLMMK15Q4Yfg"
};
```

### Logging

Cloud Run logs each redirect event with the code and destination. View logs in:

- Cloud Console → Logging → Logs Explorer
- Use filters:
  - `resource.type="cloud_run_revision"`
  - `resource.labels.service_name="your-service-name"`

---

## 📈 Analytics (GA4)

### Tracking Setup

- `lushreds.com` has GA4 installed
- UTM parameters (`utm_source`, `utm_medium`, `utm_campaign`) are embedded in redirect URLs
- GA4 automatically captures these in standard reports

### Example Flow

Scanning this:

```
https://go.lushreds.com/?c=SNACKS
```

Redirects to:

```
https://lushreds.com/?utm_source=qr&utm_medium=card&utm_campaign=SNACKS
```

These values show in GA4 as:

- **Source**: `qr`
- **Medium**: `card`
- **Campaign**: `SNACKS`

No additional configuration needed on lushreds.com or GA4.

---

## 📊 Viewing Reports in GA4

### Traffic Acquisition Report

1. Go to https://analytics.google.com/
2. Navigate to:
   - **Reports > Life cycle > Acquisition > Traffic acquisition**
3. Adjust the **date range** in the top right
4. Set dimension to `Session source / medium`
5. Filter for:
   - Source: `qr`
   - Medium: `card`
6. Campaign names (like `SNACKS`) appear in the Campaign column

---

## 🧪 Realtime Tracking

To validate redirects are working:

1. Navigate to **Reports > Realtime**
2. Watch for new users in the active users map and event stream
3. You may not see UTM values in Realtime—use **Traffic Acquisition** for verified attribution

---

## 🧭 Optional: Explore Report

If you created a custom "Explore" report:

- Go to **Explore**
- Open the saved report (e.g. `QR Campaign Tracking`)
- Use dimensions:
  - `Session source / medium`
  - `Session campaign`
- Use metrics:
  - `Event count`, `Sessions`, `Users`

---

## 🔍 Tips

- "Direct" traffic is often from you or close contacts — filter it out in reports
- "Unassigned" means no UTM or referrer was detected (common for bots, apps, or spam)
- Use UTM parameters consistently to avoid ambiguous attribution