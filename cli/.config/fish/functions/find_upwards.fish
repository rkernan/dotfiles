function find_upwards -a find -a stop
  if not test -n "$stop"
    set -f stop "/"
  end

  set -f dir (pwd)
  while not test $dir = $stop
    set -l found $dir"/"$find
    if test -e $found
      echo $found
      break
    end
    set -f dir (path normalize $dir"/..")
  end
end
