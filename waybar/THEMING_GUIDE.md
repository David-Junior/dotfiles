# Graphite Reader — Hyprland Theming Guide

This guide turns the current Waybar and its reference image into a consistent
desktop design system. It is an adaptation of HANCORE's Solitude theme: a dark
e-reader crossed with an industrial control panel, built from charcoal, steel
gray, paper white, and a trace of rust orange for exceptional states.

## 1. Design principles

1. **Dark ink dominates.** Use near-black charcoal for most large surfaces.
2. **Steel gray carries focus.** Selection and focus use cool neutral contrast,
   not a saturated desktop-wide accent.
3. **Structure replaces decoration.** Prefer spacing, thin rules, and opacity to
   rounded cards or saturated gradients. A low-contrast focus-border gradient
   is the exception inherited from Solitude.
4. **UI is sharp; imagery is organic.** Keep controls rectilinear while using
   grainy, hand-drawn, duotone wallpaper as visual contrast.
5. **Information appears on demand.** Keep default views compact; reveal values,
   descriptions, and secondary actions on hover.
6. **Motion confirms state.** Transitions should be short and quiet, never the
   main attraction.

## 2. Core tokens

Use Solitude's `colors.toml` as the source of truth. Waybar may retain its small
rust-orange interaction accent as a deliberate local variation.

| Token | Value | Use |
| --- | --- | --- |
| `background` | `#101315` | Bars, terminals, panels, launchers |
| `surface` | `#333539` | Menus, cards, inactive selections |
| `surface-raised` | `#343d41` | Hovered rows and floating utilities |
| `border` | `#4b4e55` | Outlines and separators |
| `foreground` | `#cacccc` | Primary text and icons |
| `muted` | `#565d60` | Secondary text and inactive states |
| `accent` | `#798186` | Selection, active tabs, controls |
| `focus` | `#a8adb0` | Focused window border and strong emphasis |
| `paper` | `#cbc2be` | Warm secondary highlight |
| `bright` | `#d9dbdc` | Highest neutral contrast |
| `critical` | `#de6145` | Heat and genuinely urgent states only |
| `shadow` | `#000000` | Small, dense shadows |

Aim for roughly 80% background/surface, 15% gray text, and 5% steel-gray
selection. Rust orange should normally occupy less than 1% of the screen.

### State language

| State | Treatment |
| --- | --- |
| Default | Foreground at 80–90% opacity |
| Secondary | Muted gray at 55–70% opacity |
| Hover | Steel accent or raised graphite surface |
| Active/focused | Focus gray or steel accent at full opacity |
| Disabled | Muted gray below 45% opacity |
| Warning | Warm paper or bright neutral |
| Critical | Rust orange with a short stepped pulse |
| Destructive hover | Critical foreground, never a permanent red panel |

## 3. Typography and icons

- **Interface text:** JetBrains Mono Nerd Font, regular weight.
- **Small labels:** 11–12px.
- **Normal UI:** 12–13px.
- **Headings:** 14–16px, medium weight; avoid oversized display text.
- **Icons:** Material Symbols Sharp, normally 15–18px.
- **CJK workspace glyphs:** Noto Sans fallback.
- Use italics only for dates, metadata, or deliberately secondary information.
- Keep labels short and sentence case. Put long explanations in tooltips.

Do not mix icon families inside the same control cluster. Application-owned tray
icons are the only acceptable exception.

## 4. Geometry and spacing

Use a 2px-based spacing scale: `2, 4, 6, 8, 12, 16, 24`.

- Bars and rails: 25–28px tall.
- Icon padding: 6–8px horizontally, adjusted optically when necessary.
- Compact controls: 4px between related items; 8–12px between groups.
- Window gaps: 4px inner and 5px outer.
- Borders: 1px for embedded UI; 2px for Hyprland windows and floating panels.
- Corners: 0px for bars and rails; 4–6px for windows, notifications, launchers,
  and floating controls.
- Shadows: compact UI uses 1–4px; floating windows may use Solitude's diffuse
  16px, low-opacity black shadow.

Avoid nested rounded rectangles. A panel should read as one surface, with rows
separated by space or a faint rule.

## 5. Hyprland direction

The Solitude repository uses a mostly-background active border that resolves
into steel gray, a nearly black inactive border, compact gaps, and modest
rounding. Use this source-faithful baseline in `hyprland.lua`:

```lua
hl.config({
  general = {
    gaps_in     = 4,
    gaps_out    = 5,
    border_size = 2,
    col = {
      active_border = {
        colors = {
          "rgba(101315ee)", "rgba(101315ee)", "rgba(101315ee)",
          "rgba(798186ee)", "rgba(798186ee)", "rgba(798186ee)",
          "rgba(798186ee)", "rgba(798186ee)",
        },
        angle = 90,
      },
      inactive_border = "rgb(1e1e1e)",
    },
  },

  decoration = {
    rounding       = 6,
    rounding_power = 3,
    shadow = {
      enabled      = true,
      range        = 16,
      color        = "rgba(00000052)",
    },
  },
})
```

### Motion

- Prefer fades and very small scale changes.
- Target roughly 120–220ms for menus, drawers, and focus feedback.
- Workspace transitions should be fast fades.
- Remove obvious `popin 87%` effects; if scaling is retained, use 96–98% so it
  reads as feedback rather than spectacle.
- Critical-state blinking is acceptable; ambient UI animation is not.

### Floating utilities

Use centered floating windows for short-lived terminal tools, mixers, Bluetooth,
and network configuration. Give them a fixed or proportional size, a steel-gray
border, and a dense shadow. Normal application terminals remain tiled.

## 6. Wallpaper art direction

The reference wallpaper is an important half of the theme. Look for or create:

- Duotone illustrations in charcoal and warm paper-beige.
- Ink, etching, photocopy, risograph, or manga-like line work.
- Large dark regions so foreground windows remain legible.
- One strong subject placed off-center, leaving calm negative space for windows.
- Fine grain and imperfect texture, but no saturated multicolor imagery.

Keep rust orange out of most wallpapers so critical UI feedback remains
meaningful. If it appears, restrict it to one very small detail.

## 7. Application recipes

### Kitty

The terminal should resemble dark paper, not transparent glass. Suggested base:

```conf
font_family              JetBrainsMono Nerd Font
font_size                11.5
foreground               #cacccc
background               #101315
background_opacity       0.94
cursor                   #cacccc
cursor_text_color        #101315
selection_foreground     #101315
selection_background     #798186
url_color                #a8adb0
window_padding_width     8
active_border_color      #a8adb0
inactive_border_color    #343d41
```

Use Solitude's grayscale ANSI palette, with `#de6145` reserved for bright-red
error and heat endpoints. Avoid unrelated terminal colors.

### Fuzzel or Wofi

- Near-opaque background with a one-pixel border.
- Square corners and no oversized search field.
- 8–12px internal padding.
- Muted rows by default; accent text or a thin left rule for the selected row.
- Show icons only when they improve recognition; keep them Material-like where
  the launcher controls the icon source.

### SwayNC

- One continuous notification-center surface.
- Notifications separated by 1px faint rules, not individual rounded cards.
- App name and time in muted gray; summary in foreground.
- Steel accent for unread/active controls; rust orange only for urgent alerts.
- Compact action buttons with square corners and text-first labels.

### Wlogout

- Full-screen charcoal veil around 90–94% opacity.
- Simple monochrome icons with short labels.
- Use a restrained grid with generous empty space.
- Steel accent on keyboard focus/hover; rust orange only on shutdown/reboot
  confirmation.

### Hyprlock

- Preserve the wallpaper, darkened enough for legibility.
- Center one compact time block and a thin password field.
- Use foreground gray for time, muted gray for date, and accent for input/failure
  feedback.
- Avoid blur-heavy glass panels and large circular avatars.

### GTK applications

- Prefer a dark neutral GTK theme without colored title bars.
- Keep client-side decoration rounding minimal.
- Use accent only for selection, switches, progress, and keyboard focus.
- Match cursor and selection colors to the terminal and Waybar tokens.

### Terminal TUIs

- Prefer monochrome or 16-color themes with a black/gray base.
- Highlight the selected row in steel gray or off-white, not saturated blue.
- Use thin borders and Unicode line art sparingly.
- Let graphs use several gray intensities before introducing accent color.

## 8. Composition rules

- Keep permanent information at screen edges; temporary interaction belongs in
  centered floating windows.
- Balance visual weight, not exact pixel width. A long media label can counter a
  cluster of small status icons.
- Reveal numbers when they are being manipulated; hide them at rest.
- Prefer one emphasized element per region.
- Avoid using rust orange for ordinary active or focused elements.
- Dense content should use alignment and monospace columns rather than boxes.

## 9. Migration order

1. Apply the palette and typography everywhere.
2. Replace the Hyprland border colors and remove large rounding.
3. Raise Kitty opacity and set its foreground/cursor/selection colors.
4. Theme Fuzzel, SwayNC, Wlogout, and Hyprlock using the same tokens.
5. Choose a duotone textured wallpaper with strong dark regions.
6. Normalize spacing and icon families after all components are visible together.
7. Test normal, hover, focused, muted, warning, critical, and disabled states.

The final test is simple: in a grayscale screenshot, hierarchy should still be
obvious. Focus should read through steel-gray contrast; rust orange should only
announce exceptional heat, danger, or urgency.
