# encoding: utf-8

cursor = TTY::Cursor

def stub_windows_platform
  OS.define_singleton_method(:windows?) do
    true
  end
end

def stub_non_windows_platform
  OS.define_singleton_method(:windows?) do
    false
  end
end

assert "shows cursor" do
  assert_equal "\e[?25h", cursor.show
end

assert "hides cursor" do
  assert_equal "\e[?25l", cursor.hide
end

assert "saves cursor position" do
  stub_non_windows_platform

  assert_equal "\e7", cursor.save
end

assert "saves cursor position on Windows" do
  stub_windows_platform

  assert_equal "\e[s", cursor.save 
end

assert "restores cursor position" do
  stub_non_windows_platform

  assert_equal "\e8", cursor.restore
end

assert "restores cursor position on Windows" do
  stub_windows_platform

  assert_equal "\e[u", cursor.restore
end

assert "gets current cursor position" do
  assert_equal "\e[6n", cursor.current
end

assert "moves cursor up default by 1 line" do
  assert_equal "\e[1A", cursor.up 
end

assert "moves cursor up by 5 lines" do
  assert_equal "\e[5A", cursor.up(5)
end

assert "moves cursor down default by 1 line" do
  assert_equal "\e[1B", cursor.down
end

assert "moves cursor down by 5 lines" do
  assert_equal "\e[5B", cursor.down(5)
end

assert "moves cursorleft by 1 line default" do
  assert_equal "\e[1D", cursor.backward 
end

assert "moves cursor left by 5" do
  assert_equal "\e[5D", cursor.backward(5) 
end

assert "moves cursor right by 1 line default" do
  assert_equal "\e[1C", cursor.forward
end

assert "moves cursor right by 5 lines" do
  assert_equal "\e[5C", cursor.forward(5)
end

assert "moves cursor horizontal to start" do
  assert_equal "\e[1G", cursor.column
end

assert "moves cursor horizontally to 66th position" do
  assert_equal "\e[66G", cursor.column(66)
end

assert "moves cursor vertically to start" do
  assert_equal "\e[1d", cursor.row
end

assert "moves cursor vertically to 50th row" do
  assert_equal "\e[50d", cursor.row(50)
end

assert "moves cursor to next line" do
  assert_equal "\e[E\e[1G", cursor.next_line
end

assert "moves cursor to previous line" do
  assert_equal "\e[A\e[1G", cursor.prev_line
end

assert "hides cursor for the duration of block call" do
  stream = StringIO.new
  cursor.invisible(stream) { }
  assert_equal "\e[?25l\e[?25h", stream.string
end
