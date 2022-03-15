function time_conv -a ms
  set h (math -s0 "($ms / (1000 * 60 * 60)) % 24")
  set m (math -s0 "($ms / (1000 * 60)) % 60")
  set s (math -s3 "($ms / 1000) % 60")
  set res
  test $h -gt 0 && set res $res $h'h'
  test $m -gt 0 && set res $res $m'm'
  test $s -gt 0 && set res $res $s's'
  string trim "$res"
end
