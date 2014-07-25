/***
  Copyright (C) 2014 Keith Gonyon <kgonyon@gmail.com>
  This program is free software: you can redistribute it and/or modify it
  under the terms of the GNU Lesser General Public License version 3, as published
  by the Free Software Foundation.
  This program is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranties of
  MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
  PURPOSE. See the GNU General Public License for more details.
  You should have received a copy of the GNU General Public License along
  with this program. If not, see 
***/
namespace MouseTouchpad {
	public class MousePage : AbstractPage {
        /* ---- Layout Variables ---- */

        Gtk.Grid pointer_scale_grid;

        /* ---- Widget Variables ---- */

        Gtk.Label pointer_speed_label;
        Gtk.Label acceleration_slow_label;
        Gtk.Label acceleration_fast_label;
        Gtk.Scale acceleration_scale;

        private MouseSettings mouse_settings;

		public MousePage () {
            /* ---- Init Settings ---- */

			mouse_settings = new MouseSettings ();

            /* ---- Init Widgets ---- */

            // Pointer speed
            pointer_scale_grid      = new Gtk.Grid ();
            pointer_speed_label     = new Gtk.Label (_("<b>Pointer Speed:</b>"));
            acceleration_slow_label = new Gtk.Label(_("<i>Slow</i>"));
            acceleration_fast_label = new Gtk.Label(_("<i>Fast</i>"));
            acceleration_scale      = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 1, 10, 1);

            setup_widgets ();
            setup_signals ();

            /* ---- Attach widgets ---- */

            // Pointer speed
            pointer_scale_grid.attach (acceleration_slow_label, 0, 1, 1, 1);
            pointer_scale_grid.attach (acceleration_scale,      1, 1, 3, 1);
            pointer_scale_grid.attach (acceleration_fast_label, 4, 1, 1, 1);
            this.attach (pointer_speed_label,     0, 0, 1, 1);
            this.attach (pointer_scale_grid,      0, 1, 1, 1);
		}

		public override void reset () {

		}

		private void setup_widgets () {
            /* ---- Grids ---- */

            // Pointer Scale
            pointer_scale_grid.column_spacing     = 12;
            pointer_scale_grid.margin_top         = 12;
            pointer_scale_grid.margin_start       = 12;
            pointer_scale_grid.column_homogeneous = false;
            pointer_scale_grid.row_homogeneous    = false;

            /* ---- Widgets ---- */

            // Pointer speed
            pointer_speed_label.halign         = Gtk.Align.START;
            pointer_speed_label.use_markup     = true;
            acceleration_fast_label.use_markup = true;
            acceleration_slow_label.use_markup = true;
            acceleration_scale.draw_value      = false;
            acceleration_scale.hexpand         = true;
            acceleration_scale.set_value (mouse_settings.motion_acceleration);

		}

		private void setup_signals () {
            // Pointer Speed
            acceleration_scale.value_changed.connect (() => {
                mouse_settings.motion_acceleration = acceleration_scale.adjustment.value;
                mouse_settings.motion_threshold    = (int) (11.0 - acceleration_scale.adjustment.value);
            });

            mouse_settings.changed["motion-acceleration"].connect (() => {
                acceleration_scale.adjustment.value = mouse_settings.motion_acceleration;
            });

		}
	}
}