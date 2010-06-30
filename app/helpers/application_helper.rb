# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def calendar(obj, attr, time=false, onupdate=nil)
    #http://www.dynarch.com/demos/jscalendar/doc/html/reference.html#node_sec_5.3.5
    val = "<img src=\"/images/calendar.png\"\n"
    val += "      id=\"#{obj}_#{attr}_tr\"\n"
    val += "      class=\"calIcon\"\n"
    val += "      title=\"date selector\"\n"
    val += "      onmouseover=\"this.style.background='red';\"\n"
    val += "      onmouseout=\"this.style.background=''\"/>\n"
    val += "<script type=\"text/javascript\">\n"
    val += "     Calendar.setup({\n"
    val += "      inputField     :    \"#{obj}_#{attr}\",\n"
    if time
      val += "      ifFormat       :    \"%b %e, %Y %H:%M\",\n"
      val += "      showsTime      :    \"true\",\n"
    else
      val += "      ifFormat       :    \"%b %e, %Y\",\n"
    end
    if onupdate
      val += "      onUpdate       :    #{onupdate},\n"
    end
    val += "      button         :    \"#{obj}_#{attr}_tr\",\n"
    val += "      weekNumbers    :    false,\n"
    val += "      cache          :    true\n"
    val += "      });\n"
    val += "</script>\n"
  end
  
  def inline_edit(element, display, url, size, highlight, field)
    val = "<span id=\"#{element}\">#{display}</span>\n"
    val += "<script type=\"text/javascript\">\n"
    val += "    new Ajax.InPlaceEditor('#{element}', '#{url}', {okControl:false, size:#{size}, highlightColor:\"#bbbbbb\", highlightEndColor:\"#{highlight}\", callback: function(form, value) { return 'field=#{field}&value='+encodeURIComponent(value)} });\n"
    val += "</script>\n"
  end
  
end
