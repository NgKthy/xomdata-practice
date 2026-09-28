/**
 * portfolio/assets/app.js
 * Renders all 9 sections of the dashboard from data/data.json
 */

(async function () {
  // ─── Read URL filter state ───────────────────────────────────────
  const params = new URLSearchParams(window.location.search);
  let state = {
    lang: params.get('lang') || 'all',
    diff: params.get('diff') || 'all',
    showAll: false
  };

  const PAGE_SIZE = 20;

  // ─── Fetch data ──────────────────────────────────────────────────
  let data;
  try {
    const res = await fetch('data/data.json', { cache: 'no-store' });
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    data = await res.json();
  } catch (err) {
    console.error('Failed to load data.json', err);
    document.getElementById('sync-badge').setAttribute('data-state', 'failed');
    document.getElementById('sync-badge').textContent = '! Data load failed';
    return;
  }

  // ─── Determine sync state ────────────────────────────────────────
  const ageMs  = Date.now() - new Date(data.generated_at);
  const ageH   = ageMs / 3_600_000;
  const syncState = ageH < 1 ? 'synced' : ageH < 24 ? 'stale' : 'failed';
  const syncLabel = ageH < 1 ? '● Sync active' : ageH < 24 ? '◐ Recently synced' : '! Stale data';

  document.querySelectorAll('#sync-badge').forEach(el => {
    el.setAttribute('data-state', syncState);
    el.textContent = syncLabel;
  });

  // ─── Run all renderers ───────────────────────────────────────────
  renderKPIs(data);
  renderDistributions(data);
  renderTrend(data);
  renderFocus(data);
  renderSolutions(data);
  renderHeatmap(data);
  renderSyncStatus(data);
  renderFreshness(data);
  bindFilters(data);

  // ═══════════════════════════════════════════════════════════════
  // SECTION 03 — KPI Cards
  // ═══════════════════════════════════════════════════════════════
  function renderKPIs(d) {
    const t = d.totals;
    animateCounter('kpi-accepted',  t.accepted,    0);
    animateCounter('kpi-challenges',t.challenges,  50);
    animateCounter('kpi-languages', t.languages,   100);
    animateCounter('kpi-streak',    t.streak,      150);

    const synced = document.querySelector('#kpi-synced .kpi__value');
    if (synced) {
      setTimeout(() => {
        synced.textContent = t.synced;
        synced.style.opacity = 1;
      }, 200);
    }
  }

  function animateCounter(id, target, delay = 0) {
    const el = document.querySelector(`#${id} .kpi__value`);
    if (!el) return;
    const duration = 800;
    const start    = performance.now();
    el.style.opacity = 0;

    setTimeout(() => {
      el.style.opacity = 1;
      const tick = (now) => {
        const t = Math.min((now - start) / duration, 1);
        const eased = 1 - Math.pow(1 - t, 3);
        el.textContent = Math.round(eased * target).toLocaleString();
        if (t < 1) requestAnimationFrame(tick);
        else el.textContent = target.toLocaleString();
      };
      requestAnimationFrame(tick);
    }, delay);
  }

  // ═══════════════════════════════════════════════════════════════
  // SECTION 04 — Distributions
  // ═══════════════════════════════════════════════════════════════
  function renderDistributions(d) {
    // Language bars
    const langEl = document.getElementById('lang-bars');
    if (langEl) {
      const total = Object.values(d.by_language).reduce((a,b)=>a+b, 0);
      langEl.innerHTML = '';
      Object.entries(d.by_language).sort((a,b)=>b[1]-a[1]).forEach(([lang, count]) => {
        const pct = total ? ((count / total) * 100).toFixed(1) : 0;
        const color = { python: '#60a5fa', sql: '#a78bfa', excel: '#34d399' }[lang] || '#94a3b8';
        langEl.appendChild(makeBarRow(lang.toUpperCase(), lang, count, pct, color));
      });
    }

    // Difficulty bars
    const diffEl = document.getElementById('diff-bars');
    if (diffEl) {
      const total = Object.values(d.by_difficulty).reduce((a,b)=>a+b, 0);
      diffEl.innerHTML = '';
      const order = ['easy','medium','hard','nightmare'];
      const colors = { easy:'#34d399', medium:'#fbbf24', hard:'#fb923c', nightmare:'#ef4444' };
      order.forEach(diff => {
        const count = d.by_difficulty[diff] || 0;
        const pct   = total ? ((count / total) * 100).toFixed(1) : 0;
        diffEl.appendChild(makeBarRow(capitalize(diff), diff, count, pct, colors[diff]));
      });
    }
  }

  function makeBarRow(label, cls, count, pct, color) {
    const row = document.createElement('div');
    row.className = 'bar-row';
    row.innerHTML = `
      <div class="bar-meta">
        <span class="bar-label">
          <span class="bar-label-dot" style="background:${color}"></span>
          ${escHtml(label)}
        </span>
        <span class="bar-value">${count.toLocaleString()}<span class="bar-pct">${pct}%</span></span>
      </div>
      <div class="bar-track">
        <div class="bar-fill ${cls}" data-pct="${pct}"></div>
      </div>`;
    // Animate after paint
    requestAnimationFrame(() => {
      requestAnimationFrame(() => {
        const fill = row.querySelector('.bar-fill');
        if (fill) fill.style.width = pct + '%';
      });
    });
    return row;
  }

  // ═══════════════════════════════════════════════════════════════
  // SECTION 05 — Practice Trend (SVG line chart)
  // ═══════════════════════════════════════════════════════════════
  function renderTrend(d) {
    const svg = document.getElementById('trend-chart');
    if (!svg) return;

    const trend = d.trend || [];
    if (trend.length < 2) {
      svg.innerHTML = `<text x="50%" y="50%" text-anchor="middle" fill="#475569" font-size="13">Not enough data for trend</text>`;
      return;
    }

    const W = svg.parentElement.clientWidth || 700;
    const H = 160;
    const PAD = { top: 16, right: 24, bottom: 36, left: 40 };

    const counts = trend.map(p => p.count);
    const maxV = Math.max(...counts);
    const minV = 0;

    const xScale = (i) => PAD.left + (i / (trend.length - 1)) * (W - PAD.left - PAD.right);
    const yScale = (v) => PAD.top + (1 - (v - minV) / (maxV - minV || 1)) * (H - PAD.top - PAD.bottom);

    // Grid lines
    const gridCount = 4;
    let gridSvg = '';
    for (let i = 0; i <= gridCount; i++) {
      const y = PAD.top + (i / gridCount) * (H - PAD.top - PAD.bottom);
      const val = Math.round(maxV - (i / gridCount) * maxV);
      gridSvg += `<line x1="${PAD.left}" y1="${y}" x2="${W - PAD.right}" y2="${y}" stroke="rgba(99,131,179,0.1)" stroke-dasharray="4,4"/>
        <text x="${PAD.left - 6}" y="${y+4}" text-anchor="end" fill="#475569" font-size="10">${val}</text>`;
    }

    // X axis labels
    let xLabels = '';
    trend.forEach((p, i) => {
      if (trend.length <= 6 || i % Math.ceil(trend.length / 6) === 0 || i === trend.length - 1) {
        xLabels += `<text x="${xScale(i)}" y="${H - 6}" text-anchor="middle" fill="#475569" font-size="10">${p.month}</text>`;
      }
    });

    // Gradient area
    const areaPoints = trend.map((p, i) => `${xScale(i)},${yScale(p.count)}`).join(' ');
    const areaPath = `M${xScale(0)},${H - PAD.bottom} L${areaPoints.split(' ').map((pt, i) => {
      const [px, py] = pt.split(',');
      return `${px},${py}`;
    }).join(' L')} L${xScale(trend.length-1)},${H - PAD.bottom} Z`;

    // Line
    const linePath = `M${trend.map((p,i) => `${xScale(i)},${yScale(p.count)}`).join(' L')}`;

    // Dots
    let dots = '';
    trend.forEach((p, i) => {
      dots += `<circle cx="${xScale(i)}" cy="${yScale(p.count)}" r="4" fill="#22d3ee" stroke="#080d1a" stroke-width="2">
        <title>${p.month}: ${p.count} solutions</title>
      </circle>`;
    });

    svg.setAttribute('viewBox', `0 0 ${W} ${H}`);
    svg.setAttribute('width', W);
    svg.setAttribute('height', H);
    svg.innerHTML = `
      <defs>
        <linearGradient id="areaGrad" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stop-color="#22d3ee" stop-opacity="0.25"/>
          <stop offset="100%" stop-color="#22d3ee" stop-opacity="0"/>
        </linearGradient>
      </defs>
      ${gridSvg}
      ${xLabels}
      <path d="${areaPath}" fill="url(#areaGrad)"/>
      <path d="${linePath}" fill="none" stroke="#22d3ee" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
      ${dots}
    `;

    // Total in subtitle
    const sub = document.getElementById('trend-subtitle');
    if (sub) {
      const totalTrend = counts.reduce((a,b)=>a+b,0);
      sub.textContent = `${totalTrend} solutions over ${trend.length} months`;
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // SECTION 06 — Practice Focus + Topics
  // ═══════════════════════════════════════════════════════════════
  function renderFocus(d) {
    // Practice Focus from by_language
    const focusList = document.getElementById('focus-list');
    if (focusList) {
      const entries = Object.entries(d.by_language).sort((a,b)=>b[1]-a[1]);
      const maxVal  = entries[0]?.[1] || 1;
      focusList.innerHTML = '';
      entries.forEach(([lang, count], i) => {
        const item = document.createElement('div');
        item.className = 'focus-item';
        const pct = ((count / maxVal) * 100).toFixed(0);
        item.innerHTML = `
          <span class="focus-rank">${i+1}</span>
          <span class="focus-name">${capitalize(lang)}</span>
          <div class="focus-bar-wrap"><div class="focus-bar" data-pct="${pct}"></div></div>
          <span class="focus-count">${count}</span>`;
        focusList.appendChild(item);
        requestAnimationFrame(() => requestAnimationFrame(() => {
          item.querySelector('.focus-bar').style.width = pct + '%';
        }));
      });
    }

    // Challenge Topics from by_category
    const topicsList = document.getElementById('topics-list');
    if (topicsList) {
      const entries = Object.entries(d.by_category).sort((a,b)=>b[1]-a[1]).slice(0, 8);
      topicsList.innerHTML = '';
      entries.forEach(([cat, count]) => {
        const item = document.createElement('div');
        item.className = 'topic-item';
        item.innerHTML = `
          <span class="topic-name">${escHtml(cat)}</span>
          <span class="topic-badge">${count}</span>`;
        topicsList.appendChild(item);
      });
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // SECTION 07 — Recent Solutions + Filter
  // ═══════════════════════════════════════════════════════════════
  function renderSolutions(d) {
    applyFilters(d);
  }

  function applyFilters(d) {
    const filtered = d.solutions.filter(s =>
      (state.lang === 'all' || s.lang === state.lang) &&
      (state.diff === 'all' || s.difficulty === state.diff)
    );

    const count = document.getElementById('solutions-count');
    if (count) count.textContent = `${filtered.length.toLocaleString()} solutions`;

    const tbody = document.getElementById('solutions-tbody');
    const empty  = document.getElementById('empty-state');
    const footer = document.getElementById('table-footer');
    const showBtn = document.getElementById('btn-showmore');

    if (!filtered.length) {
      if (tbody) tbody.innerHTML = '';
      if (empty)  empty.style.display = 'block';
      if (footer) footer.style.display = 'none';
      return;
    }

    if (empty) empty.style.display = 'none';

    const rows = state.showAll ? filtered : filtered.slice(0, PAGE_SIZE);
    renderRows(rows, tbody);

    if (footer && showBtn) {
      if (filtered.length > PAGE_SIZE) {
        footer.style.display = 'flex';
        showBtn.textContent = state.showAll
          ? `Show fewer (top ${PAGE_SIZE})`
          : `Show all ${filtered.length} solutions`;
      } else {
        footer.style.display = 'none';
      }
    }
  }

  function renderRows(rows, tbody) {
    if (!tbody) return;
    tbody.innerHTML = '';
    rows.forEach(s => {
      const tr = document.createElement('tr');
      tr.innerHTML = `
        <td class="sol-name" title="${escHtml(s.name)}">${escHtml(s.name)}</td>
        <td class="sol-category">${escHtml(s.category || '—')}</td>
        <td><span class="lang-chip ${s.lang}">${s.lang.toUpperCase()}</span></td>
        <td><span class="diff-chip ${s.difficulty}">${capitalize(s.difficulty)}</span></td>
        <td class="sol-date">${s.date || '—'}</td>
        <td>
          <a class="sol-link" href="${escHtml(s.url)}" target="_blank" rel="noopener" aria-label="View ${escHtml(s.name)}">↗</a>
        </td>`;
      tbody.appendChild(tr);
    });
  }

  function bindFilters(d) {
    // Sync active states from URL params
    syncFilterUI();

    document.querySelectorAll('.filter-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        const filterType = btn.dataset.filter;
        const value = btn.dataset.value;

        if (filterType === 'lang') {
          state.lang = value;
          document.querySelectorAll('[data-filter="lang"]').forEach(b => b.classList.remove('active'));
        } else if (filterType === 'diff') {
          state.diff = value;
          document.querySelectorAll('[data-filter="diff"]').forEach(b => b.classList.remove('active'));
        }

        btn.classList.add('active');
        state.showAll = false;
        updateURL();
        applyFilters(d);
      });
    });

    document.querySelectorAll('#btn-reset, #btn-reset-2').forEach(btn => {
      btn.addEventListener('click', () => {
        state = { lang: 'all', diff: 'all', showAll: false };
        document.querySelectorAll('[data-filter="lang"][data-value="all"]').forEach(b => b.classList.add('active'));
        document.querySelectorAll('[data-filter="lang"]:not([data-value="all"])').forEach(b => b.classList.remove('active'));
        document.querySelectorAll('[data-filter="diff"][data-value="all"]').forEach(b => b.classList.add('active'));
        document.querySelectorAll('[data-filter="diff"]:not([data-value="all"])').forEach(b => b.classList.remove('active'));
        updateURL();
        applyFilters(d);
      });
    });

    const showBtn = document.getElementById('btn-showmore');
    if (showBtn) {
      showBtn.addEventListener('click', () => {
        state.showAll = !state.showAll;
        applyFilters(d);
      });
    }
  }

  function syncFilterUI() {
    if (state.lang !== 'all') {
      document.querySelectorAll('[data-filter="lang"]').forEach(b => b.classList.remove('active'));
      const active = document.querySelector(`[data-filter="lang"][data-value="${state.lang}"]`);
      if (active) active.classList.add('active');
    }
    if (state.diff !== 'all') {
      document.querySelectorAll('[data-filter="diff"]').forEach(b => b.classList.remove('active'));
      const active = document.querySelector(`[data-filter="diff"][data-value="${state.diff}"]`);
      if (active) active.classList.add('active');
    }
  }

  function updateURL() {
    const p = new URLSearchParams();
    if (state.lang !== 'all') p.set('lang', state.lang);
    if (state.diff !== 'all') p.set('diff', state.diff);
    const qs = p.toString();
    const newUrl = qs ? `${location.pathname}?${qs}` : location.pathname;
    history.replaceState(null, '', newUrl);
  }

  // ═══════════════════════════════════════════════════════════════
  // SECTION 08 — Activity Heatmap
  // ═══════════════════════════════════════════════════════════════
  function renderHeatmap(d) {
    const wrap = document.getElementById('heatmap');
    if (!wrap) return;

    const activity = d.activity || {};
    const today = new Date();
    const WEEKS = 26; // ~6 months back
    const DAYS  = 7;

    // Build a 26-week grid ending today
    const endDate   = new Date(today);
    endDate.setDate(endDate.getDate() - endDate.getDay()); // start of this week (Sunday)
    const startDate = new Date(endDate);
    startDate.setDate(startDate.getDate() - (WEEKS - 1) * 7);

    // All counts for level thresholds
    const counts = Object.values(activity).filter(v => v > 0);
    const maxC = Math.max(...counts, 1);
    const levelThresholds = [0, maxC * 0.2, maxC * 0.4, maxC * 0.7];

    function getLevel(count) {
      if (!count) return 0;
      if (count <= levelThresholds[1]) return 1;
      if (count <= levelThresholds[2]) return 2;
      if (count <= levelThresholds[3]) return 3;
      return 4;
    }

    function toISO(date) {
      return date.toISOString().slice(0, 10);
    }

    // Build grid: outer = days of week (0=Sun..6=Sat), inner = weeks
    wrap.innerHTML = '';
    const DAYS_OF_WEEK = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    // Create one row per day of week
    for (let d = 0; d < DAYS; d++) {
      const row = document.createElement('div');
      row.className = 'hm-row';

      const label = document.createElement('div');
      label.className = 'hm-label';
      label.textContent = [0, 2, 4].includes(d) ? DAYS_OF_WEEK[d] : '';
      row.appendChild(label);

      for (let w = 0; w < WEEKS; w++) {
        const cellDate = new Date(startDate);
        cellDate.setDate(cellDate.getDate() + w * 7 + d);

        const iso   = toISO(cellDate);
        const count = activity[iso] || 0;
        const level = getLevel(count);

        const cell = document.createElement('div');
        cell.className = 'hm-cell';
        cell.setAttribute('data-level', level);
        if (count > 0) {
          cell.title = `${iso}: ${count} solution${count !== 1 ? 's' : ''}`;
        }

        // Tooltip on hover
        cell.addEventListener('mouseenter', showTooltip);
        cell.addEventListener('mouseleave', hideTooltip);
        cell.dataset.date = iso;
        cell.dataset.count = count;

        row.appendChild(cell);
      }
      wrap.appendChild(row);
    }

    // Activity subtitle
    const totalDays = Object.keys(activity).length;
    const totalSols = Object.values(activity).reduce((a,b)=>a+b,0);
    const sub = document.getElementById('activity-subtitle');
    if (sub) sub.textContent = `${totalSols} solutions across ${totalDays} active days`;
  }

  // Tooltip
  let tooltip = null;

  function showTooltip(e) {
    const cell = e.currentTarget;
    const count = parseInt(cell.dataset.count, 10);
    if (count === 0) return;

    if (!tooltip) {
      tooltip = document.createElement('div');
      tooltip.className = 'hm-tooltip';
      document.body.appendChild(tooltip);
    }

    tooltip.textContent = `${cell.dataset.date}: ${count} solution${count !== 1 ? 's' : ''}`;
    tooltip.style.opacity = '1';
    tooltip.style.left = (e.clientX + 12) + 'px';
    tooltip.style.top  = (e.clientY - 28) + 'px';
  }

  function hideTooltip() {
    if (tooltip) tooltip.style.opacity = '0';
  }

  document.addEventListener('mousemove', e => {
    if (tooltip && tooltip.style.opacity === '1') {
      tooltip.style.left = (e.clientX + 12) + 'px';
      tooltip.style.top  = (e.clientY - 28) + 'px';
    }
  });

  // ═══════════════════════════════════════════════════════════════
  // SECTION 08 — Sync Status
  // ═══════════════════════════════════════════════════════════════
  function renderSyncStatus(d) {
    const badgeDetail = document.getElementById('sync-badge-detail');
    if (badgeDetail) {
      badgeDetail.setAttribute('data-state', syncState);
      badgeDetail.textContent = ageH < 1 ? '● Synced' : ageH < 24 ? '◐ Recently synced' : '! Stale';
    }

    const commitEl = document.getElementById('sync-commit');
    if (commitEl) commitEl.textContent = d.source_commit || 'unknown';

    const timeEl = document.getElementById('sync-time');
    if (timeEl) timeEl.textContent = formatDate(d.generated_at);

    const totalEl = document.getElementById('sync-total');
    if (totalEl) totalEl.textContent = `${d.totals?.grand?.toLocaleString() || 0} solutions`;
  }

  // ═══════════════════════════════════════════════════════════════
  // SECTION 09 — Freshness
  // ═══════════════════════════════════════════════════════════════
  function renderFreshness(d) {
    const el = document.getElementById('freshness');
    if (!el) return;
    const mins = Math.floor(ageMs / 60000);
    if (mins < 1)    el.textContent = 'just now';
    else if (mins < 60) el.textContent = `${mins} phút trước`;
    else if (mins < 1440) el.textContent = `${Math.floor(mins / 60)} giờ trước`;
    else el.textContent = `${Math.floor(mins / 1440)} ngày trước`;
  }

  // ═══════════════════════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════════════════════
  function capitalize(str) {
    return str ? str.charAt(0).toUpperCase() + str.slice(1) : '';
  }

  function escHtml(str) {
    return String(str || '').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
  }

  function formatDate(iso) {
    if (!iso) return '—';
    try {
      const d = new Date(iso);
      return d.toLocaleString('en-US', { dateStyle: 'medium', timeStyle: 'short', timeZone: 'UTC' }) + ' UTC';
    } catch {
      return iso;
    }
  }

})();
