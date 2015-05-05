:- module(accordion_demo, []).

/** <module> Accordion demo

Generates an HTML demo page for the accordion component.

@author Anne Ogborn
@license Lesser General Public License Vers. 3, June 2007.
@version 2013-2015
*/

:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(wl/nav/accordion)).

:- http_handler(root(accordion), accordion_demo, [id(accordion)]).

:- multifile(weblogdemo:label/2).
weblogdemo:label(accordion, 'accordion menus').



accordion_demo(_) :-
	reply_html_page(wl_demo, title('Accordion Demo'), \acc_demo_body).

acc_demo_body -->
	html([
	    h1('Accordion demo page'),
	    p('Accordion widget using the jQueryui accordion'),
	     h2('Tasty Recipes, Too Many For One Page!'),
	    \accordion([], [
		 \accordion_section('Taco Salad',
		         \recipe(taco_salad)),
		 \accordion_section('Grilled Cheese Sandwich',
		         \recipe(grilled_cheese)),
		 \accordion_section('Tang',
		     div([
			p('ingredients:'),
		        ul([
			  li('1 Tbspn Tang powder'),
			  li('20 oz cold water')
		          ]),
		        p('Mix Tang powder into cold water. Serve')
		        ]))
	         ]),
	    h2('Collapsible Version'),
	    p('Usually one section is always open. This version can close all sections'),
	    \accordion([id(collapsibleversion), collapsible(true)], [
		 \accordion_section('Taco Salad',
		         \recipe(taco_salad)),
		 \accordion_section('Grilled Cheese Sandwich',
		         \recipe(grilled_cheese)),
		 \accordion_section('Tang',
		     div([
			p('ingredients:'),
		        ul([
			  li('1 Tbspn Tang powder'),
			  li('20 oz cold water')
		          ]),
		        p('Mix Tang powder into cold water. Serve')
		        ]))
	         ]),
	    h2('Fancy Icons  (custom classes)!'),
	    p('Adds icons for disclosure triangles'),
	    \accordion([id(fancyicons),
			active('ui-icon-circle-arrow-s'),
			inactive('ui-icon-circle-arrow-e')], [
		 \accordion_section('Taco Salad',
		         \recipe(taco_salad)),
		 \accordion_section('Grilled Cheese Sandwich',
		         \recipe(grilled_cheese)),
		 \accordion_section('Tang',
		     div([
			p('ingredients:'),
		        ul([
			  li('1 Tbspn Tang powder'),
			  li('20 oz cold water')
		          ]),
		        p('Mix Tang powder into cold water. Serve')
		        ]))
	         ]),
	    h2('Space Fill!'),
	    p('This variation always fills a fixed height'),
	    style(
  '\n#spacefill {
    padding: 10px;
    width: 550px;
    height: 320px;
  }\n'
		 ),
	    \accordion([id(spacefill),
			height(fill)
			], [
		 \accordion_section('Taco Salad',
		         \recipe(taco_salad)),
		 \accordion_section('Grilled Cheese Sandwich',
		         \recipe(grilled_cheese)),
		 \accordion_section('Tang',
		     div([
			p('ingredients:'),
		        ul([
			  li('1 Tbspn Tang powder'),
			  li('20 oz cold water')
		          ]),
		        p('Mix Tang powder into cold water. Serve')
		        ]))
	         ]),
	    h2('Hover Open!'),
	    p('This is broken in jQueryui'),
	    \accordion([id(hovercraft),
			hover(true)
			], [
		 \accordion_section('Taco Salad',
		         \recipe(taco_salad)),
		 \accordion_section('Grilled Cheese Sandwich',
		         \recipe(grilled_cheese)),
		 \accordion_section('Tang',
		     div([
			p('ingredients:'),
		        ul([
			  li('1 Tbspn Tang powder'),
			  li('20 oz cold water')
		          ]),
		        p('Mix Tang powder into cold water. Serve')
		        ]))
	         ]),
	    h2('Sortable!'),
	    p('Try dragging sections'),
	    \accordion([id(sortme),
			sortable(true)
			], [
		 div(class=group,
		    \accordion_section('Taco Salad',
		         \recipe(taco_salad))),
		 div(class=group,
		    \accordion_section('Grilled Cheese Sandwich',
		         \recipe(grilled_cheese))),
		 div(class=group,
		    \accordion_section('Tang',
		     div([
			p('ingredients:'),
		        ul([
			  li('1 Tbspn Tang powder'),
			  li('20 oz cold water')
		          ]),
		        p('Mix Tang powder into cold water. Serve')
		        ])))
	         ])
	    ]).



recipe(ID) -->
	{
	    setof(li(Ingredient), ingredient(ID, Ingredient), Ingredients),
	    procedure(ID, Procedure)
	},
	html([
	    div([
		p('ingredients:'),
		ul(Ingredients),
		p('Procedure:'),
		ul(Procedure)
		])
	     ]).


ingredient(taco_salad,  '12" flour tortilla').
ingredient(taco_salad, '6 oz iceberg lettuce').
ingredient(taco_salad, '6 oz hamburger').
ingredient(taco_salad, 'Durkees taco seasonings').
ingredient(taco_salad, 'grated mixed cheddar and Mozarella cheese').
ingredient(taco_salad, '2oz Salsa Fresca').
ingredient(grilled_cheese, 'white or sourdough bread').
ingredient(grilled_cheese, 'American cheese, pre-wrapped slices').
procedure(taco_salad,
'Place tortilla over flat bottom wire strainer and fry for 15 seconds to make
bowl. Mix hamburger with taco seasonings and fry. Chop lettuce into 1" cubes and separate. Mix lettuce with half of hamburger and cheese and place in bowl.
Add remaining ingredients to top.').
procedure(grilled_cheese,
'Place 3 slices cheese between bread slices. Heat sandwich on dry griddle until cheese melts, turning halfway').
