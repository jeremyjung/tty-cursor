# encoding: utf-8
# frozen_string_literal: true

module TTY
  # Terminal cursor movement ANSI codes
  module Cursor

    ESC = "\e".freeze
    CSI = "\e[".freeze
    DEC_RST  = 'l'.freeze
    DEC_SET  = 'h'.freeze
    DEC_TCEM = '?25'.freeze

    # Make cursor visible
    # @api public
    def show
      CSI + DEC_TCEM + DEC_SET
    end
    module_function :show

    # Hide cursor
    # @api public
    def hide
      CSI + DEC_TCEM + DEC_RST
    end
    module_function :hide

    # Switch off cursor for the block
    # @api public
    def invisible(stream = $stdout)
      stream.print(hide)
      yield
    ensure
      stream.print(show)
    end
    module_function :invisible

    # Save current position
    # @api public
    def save
      OS.windows? ? CSI + 's' : ESC + '7'
    end
    module_function :save

    # Restore cursor position
    # @api public
    def restore
      OS.windows? ? CSI + 'u' : ESC + '8'
    end
    module_function :restore

    # Query cursor current position
    # @api public
    def current
      CSI + '6n'
    end
    module_function :current

    # Set the cursor absolute position
    # @param [Integer] row
    # @param [Integer] column
    # @api public
    def move_to(row = nil, column = nil)
      return CSI + 'H' if row.nil? && column.nil?
      CSI + "#{column + 1};#{row + 1}H"
    end
    module_function :move_to

    # Move cursor relative to its current position
    #
    # @param [Integer] x
    # @param [Integer] y
    #
    # @api public
    def move(x, y)
      (x < 0 ? backward(-x) : (x > 0 ? forward(x) : '')) +
      (y < 0 ? down(-y) : (y > 0 ? up(y) : ''))
    end
    module_function :move

    # Move cursor up by n
    # @param [Integer] n
    # @api public
    def up(n = nil)
      CSI + "#{(n || 1)}A"
    end
    module_function :up
    alias cursor_up up

    # Move the cursor down by n
    # @param [Integer] n
    # @api public
    def down(n = nil)
      CSI + "#{(n || 1)}B"
    end
    module_function :down
    alias cursor_down down

    # Move the cursor backward by n
    # @param [Integer] n
    # @api public
    def backward(n = nil)
      CSI + "#{n || 1}D"
    end
    module_function :backward
    alias cursor_backward backward

    # Move the cursor forward by n
    # @param [Integer] n
    # @api public
    def forward(n = nil)
      CSI + "#{n || 1}C"
    end
    module_function :forward
    alias cursor_forward forward

    # Cursor moves to nth position horizontally in the current line
    # @param [Integer] n
    #   the nth aboslute position in line
    # @api public
    def column(n = nil)
      CSI + "#{n || 1}G"
    end
    module_function :column

    # Cursor moves to the nth position vertically in the current column
    # @param [Integer] n
    #   the nth absolute position in column
    # @api public
    def row(n = nil)
      CSI + "#{n || 1}d"
    end
    module_function :row

    # Move cursor down to beginning of next line
    # @api public
    def next_line
      CSI + 'E' + column(1)
    end
    module_function :next_line

    # Move cursor up to beginning of previous line
    # @api public
    def prev_line
      CSI + 'A' + column(1)
    end
    module_function :prev_line

    # Erase n characters from the current cursor position
    # @api public
    def clear_char(n = nil)
      CSI + "#{n}X"
    end
    module_function :clear_char

    # Erase the entire current line and return to beginning of the line
    # @api public
    def clear_line
      CSI + '2K' + column(1)
    end
    module_function :clear_line

    # Erase from the beginning of the line up to and including
    # the current cursor position.
    # @api public
    def clear_line_before
      CSI + '0K'
    end
    module_function :clear_line_before

    # Erase from the current position (inclusive) to
    # the end of the line
    # @api public
    def clear_line_after
      CSI + '1K'
    end
    module_function :clear_line_after

    # Clear a number of lines
    #
    # @param [Integer] n
    #   the number of lines to clear
    # @param [Symbol] :direction
    #   the direction to clear, default :up
    #
    # @api public
    def clear_lines(n, direction = :up)
      n.times.reduce([]) do |acc, i|
        dir = direction == :up ? up : down
        acc << clear_line + ((i == n - 1) ? '' : dir)
      end.join
    end
    module_function :clear_lines
    alias clear_rows clear_lines

    # Clear screen down from current position
    # @api public
    def clear_screen_down
      CSI + 'J'
    end
    module_function :clear_screen_down

    # Clear screen up from current position
    # @api public
    def clear_screen_up
      CSI + '1J'
    end
    module_function :clear_screen_up

    # Clear the screen with the background colour and moves the cursor to home
    # @api public
    def clear_screen
      CSI + '2J'
    end
    module_function :clear_screen
  end # Cursor
end # TTY
