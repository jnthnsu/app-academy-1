module TracksHelper
  def ugly_lyrics lyrics
    lyrics = lyrics.split("\n")
    lyrics.map!{|lyric| "&#9835; #{lyric}"}
    lyrics = lyrics.join
    "<pre>#{lyrics}</pre>".html_safe
  end
end
