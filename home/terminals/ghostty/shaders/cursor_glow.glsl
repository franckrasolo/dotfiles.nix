// Concentric glow around the cursor.
// Emits soft, rhythmically pulsing rings that radiate from the cursor center,
// layered over the terminal contents without obscuring text.

const vec3  GLOW_COLOR     = vec3(0.36, 0.78, 1.00); // cool cyan-blue core
const vec3  GLOW_ACCENT    = vec3(0.95, 0.55, 1.00); // magenta outer tint
const float RING_COUNT     = 4.0;                    // number of concentric rings
const float RING_THICKNESS = 0.015;                  // half-width of each ring (normalized units)
const float RING_SPACING   = 0.06;                   // radial spacing between rings
const float PULSE_SPEED    = 1.6;                    // pulses per second
const float GLOW_RADIUS    = 0.125;                  // overall glow falloff radius
const float GLOW_INTENSITY = 0.70;                   // master brightness
const float GLOW_DURATION  = 0.75;                   // seconds the glow lingers after a cursor move

// Signed distance to an axis-aligned rectangle.
float sdfRect(in vec2 p, in vec2 center, in vec2 halfSize) {
    vec2 d = abs(p - center) - halfSize;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

// Map pixel-space value to a -1..1 space preserving aspect ratio on Y.
vec2 norm(vec2 v, float isPosition) {
    return (v * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec4 base = texture(iChannel0, fragCoord.xy / iResolution.xy);

    // Normalize fragment and cursor rect into the same space.
    vec2 vu        = norm(fragCoord, 1.0);
    vec4 cursor    = vec4(norm(iCurrentCursor.xy, 1.0), norm(iCurrentCursor.zw, 0.0));
    vec2 halfSize  = cursor.zw * 0.5;
    // iCurrentCursor.xy is the top-left of the cell; the center is offset by (+w/2, -h/2).
    vec2 center    = cursor.xy + vec2(halfSize.x, -halfSize.y);

    // Distance from this fragment to the cursor rectangle surface (outside only).
    float d = max(sdfRect(vu, center, halfSize), 0.0);

    // Animated phase so the rings breathe outward continuously.
    float phase = iTime * PULSE_SPEED;

    // Accumulate contribution from each concentric ring.
    float rings = 0.0;
    for (float i = 0.0; i < RING_COUNT; i += 1.0) {
        // Each ring's radius drifts outward over time, wrapping at GLOW_RADIUS.
        float offset = fract(phase + i / RING_COUNT) * GLOW_RADIUS;
        float r      = offset + i * RING_SPACING;
        // Gaussian-ish band centered at radius r.
        float band   = exp(-pow((d - r) / RING_THICKNESS, 2.0));
        // Fade each ring as it expands so the outermost ring dissolves smoothly.
        float fade   = 1.0 - smoothstep(0.0, GLOW_RADIUS, r);
        rings       += band * fade;
    }

    // Soft ambient halo that hugs the cursor tightly.
    float halo = exp(-d * 10.0);

    // Blend core (cyan) into accent (magenta) as distance grows.
    vec3 glowTint = mix(GLOW_COLOR, GLOW_ACCENT, smoothstep(0.0, GLOW_RADIUS, d));

    // Fade the glow out over GLOW_DURATION seconds after the last cursor move,
    // then fully suppress it until the next move.
    float sinceMove = iTime - iTimeCursorChange;
    float lifetime  = 1.0 - smoothstep(0.0, GLOW_DURATION, sinceMove);

    vec3 glow     = glowTint * (rings + halo) * GLOW_INTENSITY * lifetime;

    // Additive composite so the glow illuminates rather than replaces the terminal.
    fragColor = vec4(base.rgb + glow, base.a);
}
