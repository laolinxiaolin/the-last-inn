class_name GameData

## All concept-demo content: brews, quests, and the night-one cast.
## Placeholder dialogue — real writing comes later in the full game.

static func brews() -> Array:
	return [
		{"id": "common", "name": "Common Ale", "color": "E8A33D",
			"line": "Honest. Cheap. The house pour."},
		{"id": "strong", "name": "The Strong", "color": "8C4A1F",
			"line": "Heavy, old. Loosens tongues."},
		{"id": "quiet", "name": "The Quiet", "color": "E8C66A",
			"line": "Warm, honeyed. Steadies shaking hands."},
		{"id": "bitter", "name": "The Bitter", "color": "7A8A3A",
			"line": "Sour. Makes people honest out of spite."},
		{"id": "dark", "name": "The Dark", "color": "3A2418",
			"line": "Stout. Earns trust from the silent."},
		{"id": "sweet", "name": "The Sweet", "color": "C97B6B",
			"line": "Mead. Makes people generous and loud."},
	]

static func quests() -> Array:
	return [
		{"id": "mill", "name": "A Small Problem at the Mill", "tier": "Small", "tier_color": "8C9A6B",
			"desc": "Goblins have moved into the old mill. The village wants them gone before winter.",
			"reward": "Coin, barley, a story"},
		{"id": "caravan", "name": "A Question of the Caravan", "tier": "Concerning", "tier_color": "C9A35C",
			"desc": "The deep road caravan never arrived. Someone should go look.",
			"reward": "Silver, answers"},
		{"id": "tower", "name": "A Door in the Tower", "tier": "Dire", "tier_color": "B86B5A",
			"desc": "The tower is not the problem. The tower is a door.",
			"reward": "The truth"},
	]

static func assignable_guests() -> Array:
	# id -> name shown on the board picker
	return [
		{"id": "renn", "name": "Renn"},
		{"id": "keld", "name": "Keld"},
		{"id": "woman", "name": "The woman in grey"},
	]

static func guests_night_one() -> Array:
	return [
		{
			"id": "renn",
			"name": "Renn",
			"portrait": "res://assets/char_renn.svg",
			"intro": "The door bangs open and a kid nearly falls through it — seventeen, wet, and wearing a sword twice his size.\n\n'...I'm Renn. From the mill village. We got goblins in the old mill, and Pa says fetch a hero, so I fetched one. That's you, right?'",
			"pours": {
				"common": {"react": "He gulps it like water and wipes his mouth. 'Sorry — been walking since dawn. That's good ale, that is.'",
					"read": "He gulps it like water. Starving — or hiding something."},
				"strong": {"react": "He coughs, eyes watering, then grins. 'Whew! That'll put hair on your chest. Mine too, probably.'",
					"read": "Too young to hold it — but he held it."},
				"quiet": {"react": "He goes very still. 'Oh. That's... warm. Nobody ever gave me anything warm before.'",
					"read": "Nobody's ever given him anything warm before."},
				"bitter": {"react": "He drinks it anyway, face screwed up. 'Tastes like the miller's temper. Fair enough, I'll drink it.'",
					"read": "Determined to be grateful. You like that."},
				"dark": {"react": "He takes a sip, and then he's crying a little, and he hates it. 'I'm not crying. It's the smoke. ...It's not the smoke.'",
					"read": "The dark finds the crack in everyone."},
				"sweet": {"react": "'Whoa! Is this what rich folk drink? I'm gonna tell Ma about this.' He cradles the glass like a bird.",
					"read": "He's never had anything sweet in his life. Friend for life."},
			},
			"talks": [
				{"q": "What's at the mill?", "a": "'Goblins. Moved into the old mill come harvest. They ain't done nothing yet, but Pa says wait till winter and they'll be desperate. We want 'em gone before that.'"},
				{"q": "Why should I trust you?", "a": "'I'm not much. But I'm honest, and I ain't scared, and I'll do what you say. That's all a hero is, right?'"},
				{"q": "Where'd you get that sword?", "a": "'Borrowed it. From the blacksmith.' A pause. '...He doesn't know yet.'"},
			],
		},
		{
			"id": "keld",
			"name": "Keld",
			"portrait": "res://assets/char_keld.svg",
			"intro": "A dwarf sits in the corner like he's been there since the wall was built. He says nothing for a long moment. Then:\n\n'...You pour, I'll talk. That's the trade.'\n\nHe sets a coin on the bar — old, worn smooth by a century of thumbs.",
			"pours": {
				"common": {"react": "One nod. He drinks. The nod is the review.",
					"read": "You've been judged and found adequate."},
				"strong": {"react": "He raises an eyebrow. 'You test me, innkeeper.' He drinks it all. '...Good.'",
					"read": "He approves of tests."},
				"quiet": {"react": "He holds the glass like it's warm in more ways than one. 'Kind. I remember kind. It's rare.'",
					"read": "Kindness is rare on his road."},
				"bitter": {"react": "He drinks it slow, on purpose, and sets it down. 'You want me gone. I'm still here. That's your answer.'",
					"read": "He drank it on purpose. That's his answer."},
				"dark": {"react": "He holds the glass a long moment. Then a single nod — small, and worth more than the coin.",
					"read": "The nod. It's everything. You've been marked as someone who knows."},
				"sweet": {"react": "A long silence. '...No.' He sets it down untouched.",
					"read": "Some men don't do sweet."},
			},
			"talks": [
				{"q": "What brings you here?", "a": "'The tower's not the problem.' He waits a beat. 'The tower's a door.' He doesn't explain. You get one sentence a night, and you've had it."},
				{"q": "Who are you?", "a": "'Tomb-guard. Was. My charge is dead and the thing it held is loose.' He looks at the fire. 'It came this way. I came after.'"},
				{"q": "What do you need?", "a": "'A fire that stays lit. Ale that stays honest. And to be here when it walks out.'"},
			],
		},
		{
			"id": "woman",
			"name": "The woman in grey",
			"portrait": "res://assets/char_woman.svg",
			"intro": "She pays in silver that's too new. She notices you notice. She doesn't care.\n\n'A room. And information: the caravan from the deep road never arrived. I need someone to go look.'",
			"pours": {
				"common": {"react": "'Cheap. You're reading me.' She drinks it anyway. She's not hiding — she's sorting.",
					"read": "She drinks the cheap pour to watch you watch her."},
				"strong": {"react": "She drinks it like water. No face, no pause.",
					"read": "A woman who's built a tolerance to feeling nothing."},
				"quiet": {"react": "She notices the kindness. It unsettles her more than the Bitter would have. 'Thank you. I'm not frightened. But thank you.'",
					"read": "Kindness unsettles her. Remember that."},
				"bitter": {"react": "She sets it down and meets your eyes. 'You'll have to do better than that.'",
					"read": "She's not a liar. She's just not done talking yet."},
				"dark": {"react": "She warms her hands on it. For a second, the grey woman looks tired. Then the grey comes back. '...That one was mine, once.'",
					"read": "For a second there was a person in there."},
				"sweet": {"react": "A small, real smile. 'Careful. I might stay.'",
					"read": "That smile cost her something."},
			},
			"talks": [
				{"q": "Who are you?", "a": "'The person who pays in advance and asks no questions in return. That's the best deal you'll get tonight.' She slides the coin across. 'The caravan. Someone should go look.'"},
				{"q": "What was in the caravan?", "a": "'Things that shouldn't travel the deep road. Now they're loose.' She watches you. 'You're wondering why I care. Good. Keep wondering.'"},
				{"q": "Why not go yourself?", "a": "A pause. 'Because if I go, no one comes back to tell the tale. I need someone who still can.'"},
			],
		},
		{
			"id": "fenwick",
			"name": "Fenwick",
			"portrait": "res://assets/char_fenwick.svg",
			"intro": "The door opens again and in sweeps a hat. Under the hat: a man. He bows so deep the hat nearly escapes.\n\n'Hail, keeper of the hearth! Fenwick the Magnificent, slayer of the Dread Wyrm of Garrow's Pass!' He straightens. 'I'll take the cheapest thing you have, and I'll be insulted by it.'",
			"pours": {
				"common": {"react": "'Serviceable. Like most of my audiences.' He winks. 'Present company excepted, of course.'",
					"read": "He's performing. He's always performing."},
				"strong": {"react": "'Ah — courage in a cup! I'll tell you the dragon story again! ...No? Fine. I'll hum. You'll thank me later.'",
					"read": "He steers every conversation toward the story."},
				"quiet": {"react": "'You're trying to calm me. Why would a famous dragon-slayer need calming?' A pause. '...Fair point. Another.'",
					"read": "The mask slipped for a second. He put it back."},
				"bitter": {"react": "He winces theatrically. 'You wound me, innkeeper! ...I deserved that.'",
					"read": "He knows exactly what he is."},
				"dark": {"react": "He goes quiet for once. 'Oh. This is the serious one. What's the occasion?' He drinks it slow, and for a moment he's not performing.",
					"read": "The serious pour found the real man."},
				"sweet": {"react": "He sips. His eyes go wide. He catches himself. 'Terrible. Undrinkable. The worst I've ever—' He pushes the glass forward. 'Another.'",
					"read": "He lies about everything except this."},
			},
			"talks": [
				{"q": "Tell me about the dragon.", "a": "'A tale for a song and a song for a tankard!' He leans in. 'The dragon was in a barrel, technically. I was in the barrel with it. It tripped. I won by existing. The songs leave that part out.'"},
				{"q": "Why are you really here?", "a": "A beat. Then bright again: 'Material, my friend. Every inn is a story waiting to be stolen. I mean — collected. Professionally.'"},
				{"q": "Were you on the deep road?", "a": "The smile doesn't move, but something behind it does. 'The deep road? Me? I've never—' He laughs, too loud. 'I sing about roads. I don't walk them. Ha!'"},
			],
		},
		{
			"id": "garrick",
			"name": "Garrick",
			"portrait": "res://assets/char_garrick.svg",
			"intro": "He's already there when you light the fire. Old, broad, gone soft at the edges. He doesn't look up from his ale.\n\n'Evening. ...You look tired. Fire'll keep. Sit down a while. Or don't. I'm not your mother.'",
			"pours": {
				"common": {"react": "He drinks it like it's the same ale he's drunk for thirty years. It is.",
					"read": "This man has been in this chair for years."},
				"strong": {"react": "'Trying to get me talking, eh?' A low chuckle. 'Nice try.'",
					"read": "He's seen every trick. He invented some."},
				"quiet": {"react": "He looks at the glass a long moment. 'Kindness. Been a while since anyone poured me that.'",
					"read": "He's been alone in this corner a long time."},
				"bitter": {"react": "He drinks it without a face. 'I've drunk worse. Much worse. There's a story there. You're not getting it tonight.'",
					"read": "There's a story there. You're not getting it tonight."},
				"dark": {"react": "He holds it a long time. '...Thank you.' That's all. That's everything.",
					"read": "That's everything."},
				"sweet": {"react": "He laughs, surprised. 'What's this — my birthday?' He sips it. 'Don't tell the others. They'll want some.'",
					"read": "The laugh was real. First one tonight."},
			},
			"talks": [
				{"q": "Who are you?", "a": "'Nobody. Retired. Same as you, I expect. We all end up behind a bar or in front of one.' He raises his glass. 'The bar's better. You pour, they talk, you keep the good stories.'"},
				{"q": "Did you know me?", "a": "He looks at you for a long moment. 'I know the look. That's all. The look of a man who used to be somebody.' He drinks. 'It's a good look. It means you survived.'"},
				{"q": "Will you take a quest?", "a": "He laughs, and it's warm. 'I'm retired, son. I've done my dying for this world. Now I do the sitting.' A pause. 'But I'll always be here when you close up. That's my quest.'"},
			],
		},
	]
