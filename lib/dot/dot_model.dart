/// Model representing each dot in the Matrix effect
class Dot {
  double x, y;
  final double originX, originY;
  double vx, vy;

  Dot({
    required this.x,
    required this.y,
    required this.originX,
    required this.originY,
    this.vx = 0,
    this.vy = 0,
  });
}
