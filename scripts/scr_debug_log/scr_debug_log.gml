function debug_log(message) {
    if instance_exists(obj_debug)
    {
        array_insert(obj_debug.debug_messages, 0, message) 
        if array_length(obj_debug.debug_messages) > obj_debug.max_messages {
            array_resize(obj_debug.debug_messages, obj_debug.max_messages) 
        }
    }
}
