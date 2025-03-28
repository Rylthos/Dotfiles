#include QMK_KEYBOARD_H

#if __has_include("keymap.h")

#endif

#include "gpio.h"

// Disable Power LED
void keyboard_pre_init_user(void)
{
    gpio_set_pin_output(24);
    gpio_write_pin_high(24);
}

// clang-format off
enum LAYERS { _BASE, _SYMBOL, _ARROW, _RGB, _GAME };

#ifdef ENCODER_MAP_ENABLE
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][NUM_DIRECTIONS] = {
    [_BASE]   = { ENCODER_CCW_CW(KC_VOLD, KC_VOLU), ENCODER_CCW_CW(KC_BRIU, KC_BRID) },
    [_SYMBOL] = { ENCODER_CCW_CW(KC_TRNS, KC_TRNS), ENCODER_CCW_CW(KC_TRNS, KC_TRNS) },
    [_ARROW]  = { ENCODER_CCW_CW(KC_TRNS, KC_TRNS), ENCODER_CCW_CW(KC_TRNS, KC_TRNS) },
    [_RGB]    = { ENCODER_CCW_CW(KC_TRNS, KC_TRNS), ENCODER_CCW_CW(KC_TRNS, KC_TRNS) },
    [_GAME]    = { ENCODER_CCW_CW(KC_TRNS, KC_TRNS), ENCODER_CCW_CW(KC_TRNS, KC_TRNS) },
};
#endif

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [_BASE] = LAYOUT(
          KC_ESC,    KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                              KC_6,    KC_7,    KC_8,    KC_9,    KC_0,  KC_DEL,
           KC_NO,    KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                              KC_Y,    KC_U,    KC_I,    KC_O,    KC_P, KC_MINS,
          KC_TAB,    KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                              KC_H,    KC_J,    KC_K,    KC_L, KC_SCLN, KC_RSFT,
         KC_LSFT,    KC_Z,    KC_X,    KC_C,    KC_V,    KC_B, KC_MUTE,         KC_MPLY,    KC_N,    KC_M, KC_COMM,  KC_DOT, KC_SLSH,  KC_ENT,
                           KC_LALT, KC_LCTL, KC_LGUI,MO(_SYMBOL),KC_SPC,        KC_BSPC,MO(_ARROW),KC_RGUI,KC_RCTL, KC_RALT
    ),

    [_SYMBOL] = LAYOUT(
         KC_TRNS,   KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                             KC_F6,   KC_F7,   KC_F8,   KC_F9,  KC_F10,  KC_F11,
           KC_NO, KC_EXLM,   KC_AT, KC_HASH,  KC_DLR, KC_PERC,                           KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN,  KC_F12,
          KC_GRV,    KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                              KC_6,    KC_7,    KC_8,    KC_9,    KC_0, KC_PIPE,
         KC_TRNS, KC_QUOT, KC_MINS,  KC_EQL, KC_LBRC, KC_RBRC, KC_TRNS,         KC_TRNS, KC_LBRC, KC_RBRC, KC_SCLN, KC_NUHS, KC_SLSH, KC_TRNS,
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
           KC_NO, RGB_MOD, RGB_HUI, RGB_SAI, RGB_VAI, RGB_SPI,                             KC_NO, KC_VOLD, KC_MUTE, KC_VOLU,   BL_UP, BL_TOGG,
           KC_NO, RGB_TOG, RGB_HUD, RGB_SAD, RGB_VAD, RGB_SPD,   KC_NO,           KC_NO,   KC_NO, KC_MPRV, KC_MPLY, KC_MNXT, BL_DOWN,   KC_NO,
                             KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,           KC_NO, KC_TRNS,   KC_NO,   KC_NO, KC_NO
    ),

    [_GAME] = LAYOUT(
          KC_ESC,    KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                              KC_6,    KC_7,    KC_8,    KC_9,    KC_0,TO(_BASE),
          KC_TAB,    KC_T,    KC_Q,    KC_E,    KC_E,    KC_R,                              KC_Y,    KC_U,    KC_I,    KC_O,    KC_P, KC_MINS,
         KC_LSFT,    KC_A,    KC_A,    KC_W,    KC_D,    KC_F,                              KC_H,    KC_J,    KC_K,    KC_L, KC_SCLN, KC_RSFT,
         KC_LCTL,    KC_B,    KC_Z,    KC_S,    KC_C,    KC_V, KC_MUTE,         KC_MPLY,    KC_N,    KC_M, KC_COMM,  KC_DOT, KC_SLSH,  KC_ENT,
                           KC_LALT, KC_LCTL, KC_LGUI,   KC_NO,  KC_SPC,         KC_BSPC,   KC_NO,KC_RGUI,KC_RCTL, KC_RALT
    ),
    // clang-format on
};

#ifdef OTHER_KEYMAP_C
#include OTHER_KEYMAP_C
#endif // OTHER_KEYMAP_C
