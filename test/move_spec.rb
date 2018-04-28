# encoding: utf-8

cursor = TTY::Cursor

assert "doesn't move for point (0, 0)" do
  assert_equal '', cursor.move(0, 0)
end

assert "moves only to the right" do
  assert_equal "\e[2C", cursor.move(2, 0)
end

assert "moves right and up" do
  assert_equal "\e[2C\e[3A", cursor.move(2, 3)
end

assert "moves right and down" do
  assert_equal "\e[2C\e[3B", cursor.move(2, -3)
end

assert "moves left and up" do
  assert_equal "\e[2D\e[3A", cursor.move(-2, 3)
end

assert "moves left and down" do
  assert_equal "\e[2D\e[3B", cursor.move(-2, -3)
end
