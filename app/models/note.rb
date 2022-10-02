class Note
  def initialize(starting_note:, starting_octave:, offset:)
    @note_cycle = notes.rotate(notes.index(starting_note)).cycle
    @starting_octave = starting_octave
    @offset = offset
  end

  def octave
    @starting_octave + octaves_progressed
  end

  def value
    note_progression.last
  end

  def note_progression
    @note_cycle.take(@offset + 1)
  end

  def c_start?
    @note_cycle.first == :c
  end

  def octaves_progressed
    cs_passed = note_progression.count(:c)

    if c_start?
      cs_passed -= 1
    end

    cs_passed
  end

  def notes
    [
      :a_flat,
      :a,
      :b_flat,
      :b,
      :c,
      :d_flat,
      :d,
      :e_flat,
      :e,
      :f,
      :g_flat,
      :g,
    ]
  end
end
