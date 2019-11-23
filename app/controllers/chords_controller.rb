class ChordsController < ApplicationController

  def index
    render json: Chord.all
  end

  def create
    puts params
    newChord = getChord()
    if (newChord[:chordName] && !newChord[:chordName].end_with?("unknown"))
      @chord = Chord.create(
      chord_name: newChord[:chordName],
      string_1: newChord[:strings][5],
      string_2: newChord[:strings][4],
      string_3: newChord[:strings][3],
      string_4: newChord[:strings][2],
      string_5: newChord[:strings][1],
      string_6: newChord[:strings][0],
      finger_1: newChord[:fingers][5],
      finger_2: newChord[:fingers][4],
      finger_3: newChord[:fingers][3],
      finger_4: newChord[:fingers][2],
      finger_5: newChord[:fingers][1],
      finger_6: newChord[:fingers][0],
      tones: newChord[:tones],
      user_id: get_current_user.id
      )
      render json: @chord
    else
      render json: { error: "Not found! That chord isn't possible on a guitar or doesn't exist!" }
    end
  end

  def show
    render json: Chord.find(params[:id])
  end

  def destroy
    @chord = Chord.find(params[:id])
    if @chord
      @chord.destroy
      render json:  Chord.where(user_id: get_current_user.id)
    else
      render json: { error: "Error, chord not found!" }
    end
  end

  private

  def createApiUrl
    "https://api.uberchord.com/v1/chords?voicing=" +
    params[:string_6].to_s + "-" + params[:string_5].to_s + "-" +
    params[:string_4].to_s + "-" + params[:string_3].to_s + "-" +
    params[:string_2].to_s + "-" + params[:string_1].to_s
  end

  def getChord
    chordDetails = JSON.load(RestClient.get(createApiUrl))[0]
    chordname = chordDetails["chordName"]
    strings = chordDetails["strings"]
    fingering = chordDetails["fingering"]
    tones = chordDetails["tones"]
    if (strings.split(" ").uniq.length < 3 && !strings.split(" ").uniq.join("").match(/[1-9]/)) || chordname.include?("unknown")
      return { error: "Not found! That chord isn't possible on a guitar or doesn't exist!" }
    else
      newChordName = chordname.split(",")
      if newChordName.size > 1 && newChordName.last.match(/[A-G]/)
        newChordName.last.insert(0, " / ")
        chordname = newChordName.join(",")
      end
        return {
          chordName: chordname.gsub(","," ").gsub("b", '♭').gsub("#", " # "),
          strings: strings.split,
          fingers: fingering.split,
          tones: tones.gsub(",",", ")
        }
    end
  end

  def chordParams
    params.require(:query).permit(:string_1, :string_2, :string_3, :string_4, :string_5, :string_6)
  end

end
