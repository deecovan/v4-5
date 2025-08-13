# PathFollow2D
PathFollow2D nodes are used to make a child node follow a Path2D curve. 
While PathFollow2D itself handles the movement along the path, 
integrating animations with this movement typically involves 
scripting and managing the animation state of the child node.
## Core Concepts:
### Path2D and PathFollow2D Setup:
- Create a Path2D node.
- Draw your desired path using the Curve2D editor in the inspector.
- Add a PathFollow2D node as a child of the Path2D.
- Place the node you want to animate (e.g., a Sprite2D with an AnimationPlayer 
or an AnimatedSprite2D) as a child of the PathFollow2D.
### Controlling Movement:
- The PathFollow2D's progress (in pixels) or progress_ratio (0.0 to 1.0) 
properties control its position along the path.
- You typically update these properties in a script attached to the 
PathFollow2D (or its parent) within \_process() or \_physics_process(), 
incrementing them by a speed value multiplied by delta.
###Integrating Animations:
- Directional Animations: If your character has different animations 
based on movement direction (e.g., "walk_left," "walk_right"), you can determine 
the direction by comparing the current position to the previous position.
### Code

        # Example in a PathFollow2D script
        var last_position = global_position

        func _process(delta):
            # Update progress/progress_ratio
            progress += speed * delta

            var current_direction = (global_position - last_position).normalized()
            last_position = global_position

            # Assuming child is an AnimatedSprite2D
            if current_direction.x > 0:
                $AnimatedSprite2D.play("walk_right")
            elif current_direction.x < 0:
                $AnimatedSprite2D.play("walk_left")
            else:
                $AnimatedSprite2D.play("idle") # Or appropriate animation

### State-based Animations:
- For more complex states (e.g., "idle," "walking," "attacking"), you might use 
an AnimationTree or a state machine to manage the transitions between animations, 
triggered by conditions related to the PathFollow2D's movement or other game logic.
### Rotation:
- The PathFollow2D has a rotate property. If set to true, the child node 
will automatically rotate to align with the path's tangent, which is useful 
for objects that should always face the direction of movement.
## Considerations:
### Performance:
- For very long paths or many PathFollow2D nodes, consider optimizing how you 
update progress and manage animations to avoid performance bottlenecks.
### Y-Sort:
- If using YSort nodes for depth sorting, ensure your Path2D and PathFollow2D 
setup is compatible, potentially using RemoteTransform2D if the animated node 
isn't a direct child of the PathFollow2D within the YSort tree.