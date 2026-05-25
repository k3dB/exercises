class SecretHandshake
  WINK              = 'wink'
  WINK_FLAG         = 1 << 0
  DOUBLE_BLINK      = 'double blink'
  DOUBLE_BLINK_FLAG = 1 << 1
  CLOSE_EYES        = 'close your eyes'
  CLOSE_EYES_FLAG   = 1 << 2
  JUMP              = 'jump'
  JUMP_FLAG         = 1 << 3
  REVERSE_FLAG      = 1 << 4

  def initialize(flags)
    @flags = flags
  end

  def commands
    actions = []

    return actions unless @flags.is_a? Integer

    actions << WINK         if @flags & WINK_FLAG         != 0
    actions << DOUBLE_BLINK if @flags & DOUBLE_BLINK_FLAG != 0
    actions << CLOSE_EYES   if @flags & CLOSE_EYES_FLAG   != 0
    actions << JUMP         if @flags & JUMP_FLAG         != 0

    return actions.reverse if @flags & REVERSE_FLAG != 0

    actions
  end
end
