## Benchmarking

Running `vrecord` with the `-b` flag enables an experimental benchmarking mode by applying FFmpeg's `-benchmark`/`-benchmark_all` arguments for the current recording and adds time references to each logged line. This adds per-task CPU/timing data to the logs and generates a benchmarking summary document (suffixed with *benchmark\_summary.txt) and a graph (suffixed with *benchmark\_graphs.jpeg) summarizing performance across every active audiovisual stream. This is useful for comparing vrecord performance before and after development changes and possibly for diagnosing dropped frames or verifying that a machine can sustain a given vrecord configuration.

### Reading the benchmark summary

**Columns:**

- **action**: `decode`, `encode`, or `flush` (stream finalization).
- **media**: `video` or `audio`.
- **stream**: the specifier for that stream
- **label** — a human-readable tag for that stream when available.
- **n** — total number of calls for that task/stream over the whole recording.
- **user / sys / real** — *summed* microseconds across all `n` calls: total CPU time in user-space, total CPU time in kernel calls, and total wall-clock time, respectively.
- **real/user** — ratio of the two summed columns; see below.

**What to look for:**

This is a work in progress on a new feature, but here's an initial guide. Feedback welcome.

- **`decode` rows** should be very low values relative to `encode` rows as decoding uncompressed output uses far less work than encoding it. If a decode row's totals are unexpectedly high, check the capture side (device drivers, cabling, format mismatches) rather than the encode settings.
- **`encode` rows**, summed across the whole recording and should represent the most intensive processing of a vrecord capture.
- **`real/user` below 1** means that task's total wall-clock time was less than its total CPU time, i.e. work was spread across multiple cores concurrently, which is expected for most encode rows.
- **`real/user` at or above 1** means that the wall-clock time met or exceeded CPU time and that the task spent time waiting rather than computing. For decode from a live device. This sort of waiting is normal for the decoder which often waits on hardware to deliver data; howeve, for an encode row, a ratio this high would instead point to that encoder struggling to keep up in real time.
- **`flush` rows** are finalization calls (1–3 per stream) and are informational only. A flush that's unexpectedly slow could indicate an issue closing out a particular output file.
- **The `[skipped N malformed/out-of-range bench line(s)]` notice**, when present, reports lines dropped before summarizing (occasional negative times or non-numeric data). A small skipped count relative to the total line count is normal and not necessarily a sign of a problem with the recording itself.

### Reading the benchmark graph

The graph stacks one row per active stream (both input and output), all sharing a single horizontal time-based axis. Because every row shares the same x-axis, you can compare what all streams were against each other. A gap in one row means that stream was idle at that instant. When gaps and spikes align by time across rows it could indicate a system-wide one.

**Per-stream rows** (all rows except the last):

- **Green line** re the `real/user` ratio for that stream's task calls (wall-clock time relative to CPU time spent). Low and flat is healthy; spikes mean that call took longer in real time than its CPU usage alone would suggest.
- **Gray line** are the `sys/user` ratio (kernel/system-call overhead relative to CPU time). A gray line that trends upward over the course of a long recording could indicate growing buffer or scheduling overhead.
- **Red dots** mark individual calls where `real/user ≥ 1.0`. Scattered red dots are normal. A **sustained stretch of red dots** with a stretch of unusually large green spikes could indicate that the task was genuinely falling behind over time. Red-dot, green spike clusters lining up at the same timestamp across multiple rows could indicate a shared system bottleneck. A cluster isolated to one row could indicate that a specific encoder is struggling to keep up.

**Last row — encode comparison:**

All `encode_*` streams are plotted together on the same time axis, plotting each stream's **cumulative CPU time** (`user+sys`, in microseconds) rather than the ratios used above. Each line is labeled by its output/stream specifier.

- The steepest-climbing line is the encoder consuming the most CPU over the recording.
- If the slope of multiple lines change at the same timestamp that could be a system-wide issue. If only one line's slope changes relative to the others, then that encoder specifically may be impacting total CPU performance.
