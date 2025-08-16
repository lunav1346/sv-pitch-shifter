function getClientInfo()
  return {
    name = "Peach",
    category = "Peach",
    author = "LUNAV1346",
    versionNumber = 1.0,
    minEditorVersion = 65537
  }
end

function isInScale(pitch, scale)
  local usekey = {0, 2, 4, 5, 7, 9, 11}

  for i = 1, #usekey do
    if pitch % 12 == (usekey[i] + scale) % 12 then
      return true
    end
  end
  return false
end


function main()
  local myForm = {
    title = "피치조절 스크립트",
    message = "피치시프트용 스크립트",
    buttons = "OkCancel",
    widgets = {
      {
        name = "scale", type = "ComboBox",
        label = "현재 키",
        choices = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"},
        default = 0
      },
      {
        name = "mode", type = "ComboBox",
        label = "시프트 높이",
        choices = {"+6/7", "+3/4", "-3/4", "-6/7"},
        default = 2
      }
    }
  }

  local result = SV:showCustomDialog(myForm)

  if result.status == true then
    local mainEditorSelection = SV:getMainEditor():getSelection()
    local selectedNotes = mainEditorSelection:getSelectedNotes()

    for i = 1, #selectedNotes do
      local note = selectedNotes[i]

      if result.answers.mode == 0 then -- +6/7
        note:setPitch(note:getPitch() + 7)
        if isInScale(note:getPitch(), result.answers.scale) == false then
          note:setPitch(note:getPitch() - 1)
        end

      elseif result.answers.mode == 1 then -- +3/4
        note:setPitch(note:getPitch() + 3)
        if isInScale(note:getPitch(), result.answers.scale) == false then
          note:setPitch(note:getPitch() + 1)
        end

      elseif result.answers.mode == 2 then -- -3/4
        note:setPitch(note:getPitch() - 3)
        if isInScale(note:getPitch(), result.answers.scale) == false then
          note:setPitch(note:getPitch() - 1)
        end

      elseif result.answers.mode == 3 then -- -6/7
        note:setPitch(note:getPitch() - 7)
        if isInScale(note:getPitch(), result.answers.scale) == false then
          note:setPitch(note:getPitch() + 1)
        end

      end
    end

  end

  SV:finish();
end
