module ApplicationHelper

  def createlink(action,path)
    iconi = ""
    textalt = ""
    case action
      when "play"
	iconi = "play.png"
        textalt = "Play"
      when "view"
        iconi = "search.png"
        textalt = "View"
      when "edit"
        iconi = "pencil.png"
        textalt = "Edit"
      when "delete"
        iconi = "trash.png"
        textalt = "Delete"
      when "add"
        iconi = "plus.png"
        textalt = "Create"
      when "build"
        iconi = "play.png"
        textalt = "Build"
    end
    if action == "delete"
      link_to(image_tag(iconi, :class => "iconaction", :alt => textalt), path, {:class => "iconaction", confirm: 'Are you sure?', method: :delete } )
    elsif action == "build"
      link_to(image_tag(iconi, :class => "iconaction", :alt => textalt), {:controller => "infrastructures", :action => "build", :id => path}, {:class => "iconaction", confirm: 'Are you sure?', method: :post } )
    else
      link_to(image_tag(iconi, :class => "iconaction", :alt => textalt), path, {:class => "iconaction"})
     end
  end

  def playbutton
    image_tag("play.png", :class => "iconaction", :alt => "Play")
  end

end
