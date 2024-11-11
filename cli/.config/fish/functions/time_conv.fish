function time_conv -a ms
  set -l h (math -s0 "($ms / (1000 * 60 * 60)) % 24")
  set -l m (math -s0 "($ms / (1000 * 60)) % 60")
  set -l s (math -s1 "($ms / 1000) % 60")
  set -l res
  test $h -gt 0 && set -l res $res $h'h'
  test $m -gt 0 && set -l res $res $m'm'
  test $s -gt 0 && set -l res $res $s's'
  string trim "$res"
end
