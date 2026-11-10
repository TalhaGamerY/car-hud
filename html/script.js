const hud = document.getElementById('hud');
const el = {
    speed:  document.getElementById('speed'),
    units:  document.getElementById('units'),
    gear:   document.getElementById('gear'),
    rpm:    document.getElementById('rpm'),
    fuel:   document.getElementById('fuel'),
    engine: document.getElementById('engine'),
    lights: document.getElementById('lights'),
};

const themeVars = {
    accent: '--accent', background: '--bg', text: '--text',
    muted: '--muted', warning: '--warning', danger: '--danger',
};

function applyConfig(data) {
    el.units.textContent = data.units === 'mph' ? 'MPH' : 'KM/H';

    hud.classList.remove('bottom-right', 'bottom-left', 'bottom-center');
    hud.classList.add(data.position || 'bottom-right');

    for (const [key, cssVar] of Object.entries(themeVars)) {
        if (data.theme && data.theme[key]) {
            document.documentElement.style.setProperty(cssVar, data.theme[key]);
        }
    }
}

function update(data) {
    el.speed.textContent = data.speed;
    el.gear.textContent = data.gear;

    // GTA reports idle RPM as 0.2, so rescale 0.2-1.0 to 0-100%
    const rpm = data.engineOn ? Math.max(0, (data.rpm - 0.2) / 0.8) : 0;
    el.rpm.style.width = `${Math.round(rpm * 100)}%`;
    el.rpm.classList.toggle('redline', rpm > 0.9);

    const fuel = Math.max(0, Math.min(100, data.fuel));
    el.fuel.style.width = `${fuel}%`;
    el.fuel.classList.toggle('low', fuel < 20);

    el.engine.classList.remove('on', 'warning', 'danger');
    if (data.engine < 300) el.engine.classList.add('danger');
    else if (data.engine < 650) el.engine.classList.add('warning');
    else if (data.engineOn) el.engine.classList.add('on');

    el.lights.classList.toggle('on', data.lights);
}

window.addEventListener('message', ({ data }) => {
    switch (data.action) {
        case 'config':  applyConfig(data); break;
        case 'visible': hud.classList.toggle('hidden', !data.visible); break;
        case 'update':  update(data); break;
    }
});
