use <../include/threads.scad>;

metric_thread(diameter=5, pitch=0.8, length=8, internal=true);

module m5_internal() {
  metric_thread(diameter=5, pitch=0.8, length=8, internal=true);
}