#include QMK_KEYBOARD_H

#if __has_include("keymap.h")
#endif

#include "gpio.h"
#include "transactions.h"

#include "images.h"
#include "ocean_dream.h"

uint32_t oled_timer = 0;

// clang-format off
enum LAYERS { _BASE, _GAME, _SYMBOL, _CTRL, _RGB  };

const key_override_t home_left_arrow = ko_make_with_layers(MOD_MASK_CTRL, KC_LEFT, KC_HOME, 1 << _CTRL);
const key_override_t end_right_arrow = ko_make_with_layers(MOD_MASK_CTRL, KC_RGHT, KC_END, 1 << _CTRL);
const key_override_t pagedn_down_arrow = ko_make_with_layers(MOD_MASK_CTRL, KC_DOWN, KC_PGDN, 1 << _CTRL);
const key_override_t pageup_up_arrow = ko_make_with_layers(MOD_MASK_CTRL, KC_UP, KC_PGUP, 1 << _CTRL);

const key_override_t* key_overrides[] = {
    &home_left_arrow,
    &end_right_arrow,
    &pagedn_down_arrow,
    &pageup_up_arrow,
};

#ifdef ENCODER_MAP_ENABLE
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][NUM_DIRECTIONS] = {
    [_BASE]   = { ENCODER_CCW_CW(KC_VOLD, KC_VOLU), ENCODER_CCW_CW(KC_BRIU, KC_BRID) },
    [_SYMBOL] = { ENCODER_CCW_CW(KC_TRNS, KC_TRNS), ENCODER_CCW_CW(KC_TRNS, KC_TRNS) },
    [_CTRL]= { ENCODER_CCW_CW(KC_TRNS, KC_TRNS), ENCODER_CCW_CW(KC_TRNS, KC_TRNS) },
    [_RGB]    = { ENCODER_CCW_CW(KC_TRNS, KC_TRNS), ENCODER_CCW_CW(KC_TRNS, KC_TRNS) },
    [_GAME]   = { ENCODER_CCW_CW(KC_TRNS, KC_TRNS), ENCODER_CCW_CW(KC_TRNS, KC_TRNS) },
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
          KC_TAB,    KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                              KC_Y,    KC_U,    KC_I,    KC_O,    KC_P, KC_MINS,
         KC_LSFT,    KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                              KC_H,    KC_J,    KC_K,    KC_L, KC_SCLN, KC_RSFT,
         KC_LSFT,    KC_Z,    KC_X,    KC_C,    KC_V,    KC_B, KC_MUTE,         KC_MPLY,    KC_N,    KC_M, KC_COMM,  KC_DOT, KC_SLSH,  KC_ENT,
                           KC_LALT, KC_LCTL, KC_LGUI,MO(_SYMBOL),KC_SPC,        KC_BSPC,MO(_CTRL),KC_RCTL, KC_RGUI, KC_RALT
    ),

    [_GAME] = LAYOUT(
          KC_ESC,    KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                              KC_6,    KC_7,    KC_8,    KC_9,    KC_0,DF(_BASE),
          KC_TAB,    KC_T,    KC_Q,    KC_W,    KC_E,    KC_R,                              KC_Y,    KC_U,    KC_I,    KC_O,    KC_P, KC_MINS,
         KC_LSFT,    KC_G,    KC_A,    KC_S,    KC_D,    KC_F,                              KC_H,    KC_J,    KC_K,    KC_L, KC_SCLN, KC_RSFT,
         KC_LCTL,    KC_B,    KC_Z,    KC_X,    KC_C,    KC_V, KC_MUTE,         KC_MPLY,    KC_N,    KC_M, KC_COMM,  KC_DOT, KC_SLSH,  KC_ENT,
                           KC_LALT, KC_LCTL, KC_LGUI, KC_LCTL,  KC_SPC,         KC_BSPC,MO(_CTRL),KC_RGUI, KC_RCTL, KC_RALT
    ),

    [_SYMBOL] = LAYOUT(
           KC_NO,   KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                             KC_F6,   KC_F7,   KC_F8,   KC_F9,  KC_F10,  KC_F11,
           KC_NO,  KC_GRV, KC_NUHS, KC_LCBR, KC_RCBR,   KC_NO,                           KC_PPLS,    KC_7,    KC_8,    KC_9,   KC_NO,  KC_F12,
         KC_TRNS,   KC_NO, KC_QUOT, KC_LPRN, KC_RPRN,   KC_NO,                            KC_EQL,    KC_4,    KC_5,    KC_6,    KC_0,   KC_NO,
         KC_TRNS,   KC_NO, KC_NUBS, KC_LBRC, KC_RBRC,   KC_NO, KC_TRNS,         KC_TRNS, KC_MINS,    KC_1,    KC_2,    KC_3,   KC_NO,   KC_NO,
                           KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,         KC_TRNS,MO(_RGB), KC_TRNS, KC_TRNS, KC_TRNS
    ),

    [_CTRL] = LAYOUT(
           KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                            KC_F13,  KC_F14,  KC_F15,  KC_F16,  KC_F17,  KC_F18,
           KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                           MS_LEFT, MS_DOWN,   MS_UP, MS_RGHT, KC_PSCR,   KC_NO,
           KC_NO,   KC_NO, KC_VOLD, KC_MUTE, KC_VOLU,   KC_NO,                           KC_LEFT, KC_DOWN,   KC_UP, KC_RGHT, KC_SCRL,   KC_NO,
         KC_TRNS,   KC_NO, KC_MPRV, KC_MPLY, KC_MNXT,   KC_NO, KC_TRNS,         KC_TRNS, MS_BTN1, MS_WHLD, MS_WHLU, MS_BTN2, KC_PAUS, KC_TRNS,
                           KC_TRNS, KC_TRNS, KC_TRNS,MO(_RGB), KC_TRNS,         KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS
    ),

    [_RGB] = LAYOUT(
       DF(_GAME),   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                             KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
           KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                             KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
           KC_NO, RGB_MOD, RGB_HUI, RGB_SAI, RGB_VAI, RGB_SPI,                             KC_NO, KC_VOLD, KC_MUTE, KC_VOLU,   KC_NO,   KC_NO,
           KC_NO, RGB_TOG, RGB_HUD, RGB_SAD, RGB_VAD, RGB_SPD, KC_TRNS,         KC_TRNS,   KC_NO, KC_MPRV, KC_MPLY, KC_MNXT,   KC_NO,   KC_NO,
                           KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,         KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS
    ),

};
// clang-format on

void keyboard_pre_init_user(void)
{
    // Disable power LEDs
    gpio_set_pin_output(24);
    gpio_write_pin_high(24);
}

void render_oled_left(void);
void render_oled_right(void);

bool oled_task_user()
{
    if (is_keyboard_left()) {
        render_oled_left();
    } else {
        render_oled_right();
    }

    if (oled_timer == 0) {
        oled_timer = timer_read32();
    }

    if (get_current_wpm() > 0) {
        oled_on();
        oled_timer = timer_read32();
    } else if (timer_elapsed32(oled_timer) > OLED_TIMEOUT) {
        oled_off();
    }

    return false;
}

#include "oled_render.c"
