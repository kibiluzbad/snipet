// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
	$('#snippet_tags').tagSuggest({
        url: '/tags/',
        delay: 250
	});
	
    $("#snippet_language").autocomplete('/languages/', {
		width: 300,
		selectFirst: false,
      formatItem: function(row, i, max) {
			return i + "/" + max + ": " + row;
		},
		dataType: "json",
		parse: function(data) {
			return $.map(data, function(row) {
				return {
					data: row,
					value: row,
					result: row
				}
			});
		}
		});

    SyntaxHighlighter.autoloader(
      'applescript            /javascripts/shBrushAppleScript.js',
      'actionscript3 as3      /javascripts/shBrushAS3.js',
      'bash shell             /javascripts/shBrushBash.js',
      'coldfusion cf          /javascripts/shBrushColdFusion.js',
      'cpp c                  /javascripts/shBrushCpp.js',
      'c# c-sharp csharp      /javascripts/shBrushCSharp.js',
      'css                    /javascripts/shBrushCss.js',
      'delphi pascal          /javascripts/shBrushDelphi.js',
      'diff patch pas         /javascripts/shBrushDiff.js',
      'erl erlang             /javascripts/shBrushErlang.js',
      'groovy                 /javascripts/shBrushGroovy.js',
      'java                   /javascripts/shBrushJava.js',
      'jfx javafx             /javascripts/shBrushJavaFX.js',
      'js jscript javascript  /javascripts/shBrushJScript.js',
      'perl pl                /javascripts/shBrushPerl.js',
      'php                    /javascripts/shBrushPhp.js',
      'text plain             /javascripts/shBrushPlain.js',
      'py python              /javascripts/shBrushPython.js',
      'ruby rails ror rb      /javascripts/shBrushRuby.js',
      'sass scss              /javascripts/shBrushSass.js',
      'scala                  /javascripts/shBrushScala.js',
      'sql                    /javascripts/shBrushSql.js',
      'vb vbnet               /javascripts/shBrushVb.js',
      'xml xhtml xslt html    /javascripts/shBrushXml.js'
    );
    SyntaxHighlighter.all()
    
    var menuRoot = $( "#menu-root" );
    var menu = $( "#menu" );
     
    // Hook up menu root click event.
    menuRoot
    .attr( "href", "javascript:void( 0 )" )
    .click(function(){
        // Toggle the menu display.
        menu.toggle();
         
        // Blur the link to remove focus.
        menuRoot.blur();
         
        // Cancel event (and its bubbling).
        return( false );
    });
     
    // Hook up a click handler on the document so that
    // we can hide the menu if it is not the target of
    // the mouse click.
    $(document).click(function( event ){
        // Check to see if this came from the menu.
        if (menu.is( ":visible" ) &&
        !$( event.target ).closest( "#menu" ).size()){
            // The click came outside the menu, so
            // close the menu.
            menu.hide();
        }
    });
});
