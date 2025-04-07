void render_wpm(void)
{
    oled_write(" ", false);
    oled_write_ln("WPM", false);
    oled_write(" ", false);
    oled_write_ln(get_u8_str(get_current_wpm(), '0'), false);
}

void render_layer(void)
{
    switch (get_highest_layer(layer_state)) {
    case _BASE:
        oled_write_ln(" BSE ", false);
        break;
    case _SYMBOL:
        oled_write_ln(" SYM ", false);
        break;
    case _ARROW:
        oled_write_ln("ARROW", false);
        break;
    case _RGB:
        oled_write_ln(" RGB ", false);
        break;
    case _GAME:
        oled_write_ln(" GME ", false);
        break;
    }
}

void render_effect(void)
{
    if (!rgb_matrix_is_enabled()) {
        oled_write_ln(" OFF ", false);
        return;
    }

    switch (rgb_matrix_get_mode()) {
    case RGB_MATRIX_SOLID_COLOR:
        oled_write_ln("SOLID", false);
        break;
    case RGB_MATRIX_CYCLE_ALL:
        oled_write_ln("CYCLE", false);
        break;
    case RGB_MATRIX_TYPING_HEATMAP:
        oled_write_ln("THEAT", false);
        break;
    default:
        oled_write_ln("UNKWN", false);
        break;
    }
}

void render_additional_layer(void)
{
    switch (get_highest_layer(layer_state)) {
    case _RGB: {
        oled_write_ln(get_u8_str(rgb_matrix_get_hue(), '0'), false);
        oled_write_ln(get_u8_str(rgb_matrix_get_sat(), '0'), false);
        oled_write_ln(get_u8_str(rgb_matrix_get_val(), '0'), false);
        oled_write_ln(get_u8_str(rgb_matrix_get_speed(), '0'), false);

        break;
    }
    default:
        break;
    }
}

void render_oled_left()
{
    oled_clear();

    render_wpm();

    oled_set_cursor(0, 3);
    if (get_highest_layer(layer_state) == _GAME) {
        oled_write_raw_P(GAME_ICON, sizeof(GAME_ICON));
    } else {
        oled_write_raw_P(CHARACTER_ICON, sizeof(CHARACTER_ICON));
    }

    oled_set_cursor(0, 7);
    render_layer();

    oled_set_cursor(0, 8);
    render_effect();

    oled_set_cursor(0, 9);
    render_additional_layer();
}

void render_oled_right() { render_stars(); }
