if (!instance_exists(target)) exit;

x = floor(target.x - view_width / 2);

x = clamp(x, min_x, max_x);

camera_set_view_pos(camera, x, y);





