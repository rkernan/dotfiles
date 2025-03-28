function field -a position separator
  if test $separator
    awk -F $separator "{ print \$$position }"
  else
    awk "{ print \$$position }"
  end
end
