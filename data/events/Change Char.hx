import sys.io.File;
import haxe.xml.Parser;

function onEvent(changeChar) {
  if (changeChar.event.name == "Change Char") {
    var params:Array = changeChar.event.params;
    if (params.length >= 2) {
      var strumline:String = params[0];
      var newCharacterXML:String = params[1];

      trace("Strumline chosen: " + strumline);
      trace("New character XML: " + newCharacterXML);

      // Path to the strumline's XML file
      var strumlinePath:String = "assets/data/" + strumline + ".xml";

      try {
        // Read the existing XML file
        var xmlContent:String = File.getContent(strumlinePath);
        var xml:Xml = Parser.parse(xmlContent);

        // Update the XML content (example: changing a specific node or attribute)
        var characterNode:Xml = xml.firstElement();
        if (characterNode != null) {
          characterNode.set("file", newCharacterXML); // Assuming "file" is the attribute to update
        }

        // Write the updated XML back to the file
        File.saveContent(strumlinePath, xml.toString());
        trace("Successfully updated " + strumline + " to use " + newCharacterXML);
      } catch (e:Dynamic) {
        trace("Error updating XML file: " + e);
      }
    }
  }
}
