#include QMK_KEYBOARD_H

#if __has_include("keymap.h")
#endif

#include "images.h"

#include "gpio.h"

// Disable Power LED
void keyboard_pre_init_user(void)
{
    gpio_set_pin_output(24);
    gpio_write_pin_high(24);
}

// clang-format off
enum LAYERS { _BASE, _SYMBOL, _ARROW, _RGB, _GAME };
enum OLED_STATE { _OLED_ACTIVE, _OLED_SCREEN_SAVER, _OLED_OFF };

enum OLED_STATE current_oled_state = _OLED_ACTIVE;

#ifdef ENCODER_MAP_ENABLE
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][NUM_DIRECTIONS] = {
    [_BASE]   = { ENCODER_CCW_CW(KC_VOLD, KC_VOLU), ENCODER_CCW_CW(KC_BRIU, KC_BRID) },
    [_SYMBOL] = { ENCODER_CCW_CW(KC_TRNS, KC_TRNS), ENCODER_CCW_CW(KC_TRNS, KC_TRNS) },
    [_ARROW]  = { ENCODER_CCW_CW(KC_TRNS, KC_TRNS), ENCODER_CCW_CW(KC_TRNS, KC_TRNS) },
    [_RGB]    = { ENCODER_CCW_CW(KC_TRNS, KC_TRNS), ENCODER_CCW_CW(KC_TRNS, KC_TRNS) },
    [_GAME]    = { ENCODER_CCW_CW(KC_TRNS, KC_TRNS), ENCODER_CCW_CW(KC_TRNS, KC_TRNS) },
};
#endif

// [_SYMBOL] = LAYOUT(
//        KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                             KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
//        KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                             KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
//        KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                             KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
//        KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO, KC_NO,             KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
//                          KC_NO,   KC_NO,   KC_NO,   KC_NO, KC_NO,             KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO
// ),

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [_BASE] = LAYOUT(
          KC_ESC,    KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                              KC_6,    KC_7,    KC_8,    KC_9,    KC_0,  KC_DEL,
           KC_NO,    KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                              KC_Y,    KC_U,    KC_I,    KC_O,    KC_P, KC_MINS,
          KC_TAB,    KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                              KC_H,    KC_J,    KC_K,    KC_L, KC_SCLN, KC_RSFT,
         KC_LSFT,    KC_Z,    KC_X,    KC_C,    KC_V,    KC_B, KC_MUTE,         KC_MPLY,    KC_N,    KC_M, KC_COMM,  KC_DOT, KC_SLSH,  KC_ENT,
                           KC_LALT, KC_LCTL, KC_LGUI,MO(_SYMBOL),KC_SPC,        KC_BSPC,MO(_ARROW),KC_RCTL,KC_RGUI, KC_RALT
    ),

    [_SYMBOL] = LAYOUT(
           KC_NO,   KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                             KC_F6,   KC_F7,   KC_F8,   KC_F9,  KC_F10,  KC_F11,
           KC_NO,   KC_NO, KC_NUHS, KC_LCBR, KC_RCBR,   KC_NO,                           KC_PPLS,    KC_7,    KC_8,    KC_9,   KC_NO,  KC_F12,
           KC_NO,   KC_NO, KC_QUOT, KC_LPRN, KC_RPRN,   KC_NO,                            KC_EQL,    KC_4,    KC_5,    KC_6,    KC_0,   KC_NO,
         KC_TRNS,   KC_NO, KC_NUBS, KC_LBRC, KC_RBRC,   KC_NO, KC_TRNS,         KC_TRNS, KC_MINS,    KC_1,    KC_2,    KC_3,   KC_NO,   KC_NO,
                           KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,         KC_TRNS,MO(_RGB), KC_TRNS, KC_TRNS, KC_TRNS
    ),

    [_ARROW] = LAYOUT(
           KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                             KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
           KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                             KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
           KC_NO,   KC_NO, KC_VOLD, KC_MUTE, KC_VOLU,   KC_NO,                           KC_LEFT, KC_DOWN,   KC_UP, KC_RGHT,   KC_NO,   KC_NO,
           KC_NO,   KC_NO, KC_MPRV, KC_MPLY, KC_MNXT,   KC_NO,   KC_NO,           KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
                             KC_NO,   KC_NO, KC_TRNS,MO(_RGB),   KC_NO,           KC_NO, KC_TRNS, KC_TRNS,   KC_NO, KC_NO
    ),

    [_RGB] = LAYOUT(
       TO(_GAME),   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                             KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
           KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                             KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
           KC_NO, RGB_MOD, RGB_HUI, RGB_SAI, RGB_VAI, RGB_SPI,                             KC_NO, KC_VOLD, KC_MUTE, KC_VOLU,   KC_NO,   KC_NO,
           KC_NO, RGB_TOG, RGB_HUD, RGB_SAD, RGB_VAD, RGB_SPD,   KC_NO,           KC_NO,   KC_NO, KC_MPRV, KC_MPLY, KC_MNXT,   KC_NO,   KC_NO,
                             KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,           KC_NO, KC_TRNS,   KC_NO,   KC_NO, KC_NO
    ),

    [_GAME] = LAYOUT(
          KC_ESC,    KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                              KC_6,    KC_7,    KC_8,    KC_9,    KC_0,TO(_BASE),
          KC_TAB,    KC_T,    KC_Q,    KC_W,    KC_E,    KC_R,                              KC_Y,    KC_U,    KC_I,    KC_O,    KC_P, KC_MINS,
         KC_LSFT,    KC_A,    KC_A,    KC_S,    KC_D,    KC_F,                              KC_H,    KC_J,    KC_K,    KC_L, KC_SCLN, KC_RSFT,
         KC_LSFT,    KC_B,    KC_Z,    KC_X,    KC_C,    KC_V, KC_MUTE,         KC_MPLY,    KC_N,    KC_M, KC_COMM,  KC_DOT, KC_SLSH,  KC_ENT,
                           KC_LALT, KC_LCTL, KC_LGUI, KC_LCTL,  KC_SPC,         KC_BSPC,   KC_NO,KC_RGUI,KC_RCTL, KC_RALT
    ),
    // clang-format on
};

void oled_render_boot(bool bootloader)
{
    oled_clear();
    for (int i = 0; i < 16; i++) {
        oled_set_cursor(0, i);
        if (bootloader) {
            oled_write_P(PSTR("Awaiting New Firmware "), false);
        } else {
            oled_write_P(PSTR("Rebooting "), false);
        }
    }

    oled_render_dirty(true);
}

bool shutdown_user(bool jump_to_bootloader)
{
    oled_render_boot(jump_to_bootloader);

    return false;
}

void render_wpm(void)
{
    static char wpm_str[4];

    sprintf(wpm_str, "%03d", get_current_wpm());
    oled_write(" ", false);
    oled_write_ln("WPM", false);
    oled_write(" ", false);
    oled_write_ln(wpm_str, false);
}

void screensaver(void) { }

void rectangle(int top_left_x, int top_left_y, int width, int height, bool high)
{
    for (int x = top_left_x; x < top_left_x + width; x++) {
        for (int y = top_left_y; y < top_left_y + height; y++) {
            oled_write_pixel(x, y, high);
        }
    }
}

void render_modifiers(void)
{
    uint8_t mods = get_mods() | get_oneshot_mods();

    const int size = 11;
    const int half_size = (size - 1) / 2 - 1;

    // SUPER
    bool low = mods & MOD_MASK_GUI;
    bool high = !low;
    int top_left_x = 0 * 6 + 2;
    int top_left_y = 12 * 8;
    rectangle(top_left_x, top_left_y, size, size, low);
    rectangle(top_left_x + 1, top_left_y + 1, size - 2, size - 2, high);
    for (int x = 0; x < size - 2; x++) {
        for (int y = 0; y < size - 2; y++) {
            int cx = x - half_size;
            int cy = y - half_size;
            if (abs(cx) + abs(cy) < half_size + 1) {
                oled_write_pixel(top_left_x + x + 1, top_left_y + y + 1, low);
            }
        }
    }

    low = mods & MOD_MASK_SHIFT;
    high = !low;
    top_left_x = 3 * 6 + 2;
    top_left_y = 12 * 8;
    rectangle(top_left_x, top_left_y, size, size, low);
    rectangle(top_left_x + 1, top_left_y + 1, size - 2, size - 2, high);
    for (int x = 0; x < size - 2; x++) {
        for (int y = 0; y < size - 2; y++) {
            int cx = x - half_size;
            int cy = y - half_size - 2;
            if (cy <= 0 && abs(cx) + abs(cy) < half_size + 1) {
                oled_write_pixel(top_left_x + x + 1, top_left_y + y + 1, low);
            }
        }
    }

    low = mods & MOD_MASK_CTRL;
    high = !low;
    top_left_x = 0 * 6 + 2;
    top_left_y = 14 * 8;
    rectangle(top_left_x, top_left_y, size, size, low);
    rectangle(top_left_x + 1, top_left_y + 1, size - 2, size - 2, high);

    low = mods & MOD_MASK_ALT;
    high = !low;
    top_left_x = 3 * 6 + 2;
    top_left_y = 14 * 8;
    rectangle(top_left_x, top_left_y, size, size, low);
    rectangle(top_left_x + 1, top_left_y + 1, size - 2, size - 2, high);
}

bool oled_task_user()
{
    if (last_input_activity_elapsed() > OLED_SCREENSAVER_TIMEOUT) {
        current_oled_state = _OLED_SCREEN_SAVER;
    } else {
        current_oled_state = _OLED_ACTIVE;
    }

    if (last_input_activity_elapsed() > OLED_TIMEOUT) {
        current_oled_state = _OLED_OFF;
    }

    switch (current_oled_state) {
    case _OLED_ACTIVE: {
        oled_clear();
        if (is_keyboard_left()) {
            oled_advance_page(true);

            render_wpm();

            oled_set_cursor(0, 3);
            switch (get_highest_layer(layer_state)) {
            case _BASE:
            case _SYMBOL:
            case _ARROW:
            case _RGB:
                oled_write_raw_P(CHARACTER_ICON, sizeof(CHARACTER_ICON));
                break;
            case _GAME:
                oled_write_raw_P(GAME_ICON, sizeof(GAME_ICON));
                break;
            }

            render_modifiers();

        } else {
            oled_write("Right", false);
        }
        break;
    }
    case _OLED_SCREEN_SAVER:
        oled_clear();
        screensaver();
        break;
    case _OLED_OFF:
        oled_clear();
        break;
    }

    return false;
}

#ifdef OTHER_KEYMAP_C
#include OTHER_KEYMAP_C
#endif // OTHER_KEYMAP_C
