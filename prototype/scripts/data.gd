class_name GameData

## All concept-demo content: brews, quests, and the cast (night one + Grib on night two).
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


static func brew_name(id: String) -> String:
	for b in brews():
		if b["id"] == id:
			return b["name"]
	return id

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


# ---------------------------------------------------------------- returns

static func returns() -> Dictionary:
	return {
		"renn|mill": {
			"bg": "res://assets/bg_inn.svg", "portrait": "res://assets/char_renn.svg",
			"text": "The door opens on the third day. It's the kid — goblin ear on a string, grin the size of the road.\n\n'We didn't kill nobody!' he says, before you can ask. 'They're families, innkeeper. Women and littles. They just wanted a roof — the mill's been empty since the flood.'\n\nHe sets the ear on the bar. 'This is from the one who tried to bite me. I gave it back.'\n\n[i]The quest was never what the board said. You knew that. Now the kid knows it too. The village will be angry. The goblins will stay. Somewhere between them, there's a peace to be poured.[/i]"},
		"renn|caravan": {
			"bg": "res://assets/bg_inn.svg", "portrait": "res://assets/char_renn.svg",
			"text": "The kid comes back empty-handed, soaked, and furious.\n\n'The road's got more secrets than sense. I walked it twice and all I found was a hat.' He slams it on the bar. It's his hat. He wears it now.\n\n[i]Soft failures are still failures. But the hat stays.[/i]"},
		"renn|tower": {
			"bg": "res://assets/bg_inn.svg", "portrait": "res://assets/char_renn.svg",
			"text": "The kid comes back three days later, pale, and does not tell you what he saw.\n\nHe asks for the Dark. You pour it. He drinks it slow and says: 'The tower's not the problem, is it.'\n\nIt's not a question.",
		},
		"keld|mill": {
			"bg": "res://assets/bg_inn.svg", "portrait": "res://assets/char_keld.svg",
			"text": "Keld comes back from the mill with a sack of barley and a look that could curdle ale.\n\n'Goblins. Families. I sat with them.' He doesn't say more.\n\n[i]The village gets its barley. The goblins keep the mill. Somehow, Keld made both happen, and neither side knows how.[/i]"},
		"keld|caravan": {
			"bg": "res://assets/bg_inn.svg", "portrait": "res://assets/char_keld.svg",
			"text": "Keld comes back with a coin too new and a sentence:\n\n'The caravan's dead. The silver's alive. That's backwards.'\n\nHe drinks until closing. You don't ask again.",
		},
		"keld|tower": {
			"bg": "res://assets/bg_inn.svg", "portrait": "res://assets/char_keld.svg",
			"text": "The door opens on the fourth night. Keld comes in, says nothing, drinks until closing.\n\nYou ask how the tower went. He gives you one sentence:\n\n'You should have waited.'\n\nThen he drinks until closing, and you don't ask again.\n\n[i]The tower's not the problem. The tower's a door. You know that now. The question is what you'll do when it opens.[/i]"},
		"woman|mill": {
			"bg": "res://assets/bg_inn.svg", "portrait": "res://assets/char_woman.svg",
			"text": "The woman in grey comes back in three days flat.\n\n'Done,' she says. 'The mill is yours again.'\n\nYou ask about the goblins. She looks at you. 'I said the mill is yours.'\n\n[i]You decide not to ask what she means. The village names a new miller. No one mentions the goblins. No one mentions her.[/i]"},
		"woman|caravan": {
			"bg": "res://assets/bg_door.svg", "portrait": "", "kind": "courier",
			"text": "Six days pass. The door opens.\n\nA stranger stands in the rain. He's holding a sword — hers, you'd know the hilt anywhere — and a letter, dry, because he kept it under his coat.\n\n'She said to give this to you. Said you'd know what to do with it.'\n\nYou take the letter. Inside: nothing but a coin.\n\nSilver. Too new."},
		"woman|tower": {
			"bg": "res://assets/bg_inn.svg", "portrait": "res://assets/char_woman.svg",
			"text": "The woman in grey comes back changed. She does not speak of the tower.\n\nShe pays her tab in silver too new and says: 'I'll be going back out. When the door opens, send word. I'll want to be there.'\n\n[i]You believe her. That's the worst part.[/i]"},
	}


static func courier_after() -> String:
	return "You hang the sword on the wall. There were hooks waiting.\n\nThe fire pops. Somewhere in the dark, a door opens.\n\n[i]She paid in silver too new. She left in silver too new. Some debts come back. Some come back as questions.[/i]"


static func keld_dark_extra() -> String:
	return "Before he leaves, he sets something on the bar: a key, black iron, warm.\n\n'The lock in the tower. It's not a lock. It's a bell.'\n\nHe looks at you a long moment. 'You should have waited. ...You'll wait now.'"


static func renn_dark_extra() -> String:
	return "He sits down hard and cries for a minute. 'Sorry. It's the smoke. It's the— it's a lot.'\n\nThen he grins again. 'Did I do good?'\n\nYou pour him a Common and slide it over. 'Yeah, kid. You did good.'"


static func renn_quiet_extra() -> String:
	return "He stops mid-story. 'That warm ale you gave me. Nobody ever gave me anything warm before.' He doesn't know why he said it. You do."


# ---------------------------------------------------------------- night two: Grib

static func grib() -> Dictionary:
	return {
		"id": "grib",
		"name": "Grib",
		"portrait": "res://assets/char_grib.svg",
		"pours": {
			"common": {"react": "He holds the glass with both hands. 'Thank you. I've read about inns my whole life. The books said the ale is warm and the company is honest.' He sips. 'The books were right.'",
				"read": "He's never been inside an inn. He's been memorizing them from books."},
			"strong": {"react": "He takes a sip, coughs into his sleeve, politely. 'A warrior's drink. I'm an engineer — I'll stick to bridges, and ale I can walk away from.'",
				"read": "He knows his limits, and says so. Rare."},
			"quiet": {"react": "He wraps both hands around the glass. 'Warm. In the books, the hero always gets the warm one. I didn't think they'd give it to the goblin.'",
				"read": "He thought the warm glass was for heroes only."},
			"bitter": {"react": "He drinks it without complaint, sets it down, and says, very carefully: 'I will drink anything you pour, innkeeper. I hope, one day, to earn a kinder one.'",
				"read": "He will drink anything you pour. He hopes to earn a kinder one."},
			"dark": {"react": "He looks at it a long moment. 'This is the ale they give men before they do brave things. I'm not brave. I'm just polite.' He drinks it anyway. '...I'll be brave, if it's yours.'",
				"read": "He thinks courage is given, not carried. You disagree."},
			"sweet": {"react": "His eyes go very wide. He stares at the glass like it's a small miracle. 'This is... sweet. For me?' He takes the smallest sip, to make it last. 'I didn't know inns did this. I didn't know anything did this.'",
				"read": "He's never been served anything sweet. Not once."},
		},
	}


static func grib_intro(mill_state: String) -> String:
	match mill_state:
		"renn_parley":
			return "The next evening, you light the fire. A knock. Small. Polite.\n\nYou open the door. A goblin stands there — hands where you can see them, tidy clothes, a letter of introduction sealed with barley wax. He bows.\n\n'My name is Grib. I'm told the boy with the borrowed sword came home and told the village we're families, not monsters. He said the innkeeper sent him.'\n\nHe sets two coins on the bar before he's even inside. 'I came to thank the innkeeper.'"
		"keld_peace":
			return "The next evening, you light the fire. A knock. Small. Polite.\n\nYou open the door. A goblin stands there — hands where you can see them, tidy clothes. He bows, and then he's crying a little, and he hates it.\n\n'My name is Grib. The dwarf — the one with the eyes — he sat with us. Just sat. He made the village see.' He wipes his face. 'I'm sorry. It's not the smoke. It's just — nobody's ever sat with us before.'"
		"woman_dark":
			return "The next evening, you light the fire. A knock. Small. Polite.\n\nYou open the door. A goblin stands there — alone, smaller than he should be, hands where you can see them.\n\n'My name is Grib.' A pause. 'I'm told the mill is yours again. The new miller is a good man. He doesn't know what happened to the families. No one will tell him.'\n\nHe sets a letter on the bar — addressed to no one — and two coins beside it. 'I don't know who to give this to anymore. You seemed like the person who'd keep a letter.'"
		_:
			return "The next evening, you light the fire. The village road is quiet.\n\nAnd then, at dusk — a knock. Small. Polite.\n\n'Excuse me,' says a voice through the door. 'I was told this is the inn where people listen.'\n\nYou open the door. A goblin stands there — hands where you can see them, tidy clothes, a letter of introduction sealed with barley wax. He bows, and sets two coins on the bar before he's even inside.\n\n'My name is Grib. The mill sent me. The people of the mill, I mean — not the board. The board and the people... disagree about us.'"


static func grib_talks(mill_state: String) -> Array:
	var why := ""
	var need := ""
	var truth := ""
	match mill_state:
		"renn_parley":
			why = " And because the boy said you'd listen. He was right."
			need = "Nothing. The mill is settled — the way the boy told it, the way the village heard it. I came to pay the tab and say thank you. And to ask if I might come back sometimes. The books say regulars are how an inn stays alive."
			truth = "The boy with the borrowed sword walked into the middle of it and saw the truth. You sent us a listener. The board didn't survive the conversation."
		"keld_peace":
			why = " And because the dwarf said you'd sit. He was right."
			need = "Nothing. The mill is settled — though no one is quite sure how, and the dwarf isn't saying. I came to pay the tab and say thank you. And to ask if I might come back sometimes. The books say regulars are how an inn stays alive."
			truth = "The dwarf walked into the middle of it and just sat. No questions, no swords. The board didn't survive the sitting."
		"woman_dark":
			why = " And because the letter needed somewhere to go. You were the address."
			need = "Nothing. The mill is quiet now, the way the village wanted it. I came to pay the tab — and to ask if I might come back sometimes. I don't have anywhere else to keep a letter."
			truth = "The board was right about the danger. It just had the wrong danger in mind."
		_:
			need = "A parley letter, if you'll let one be written. Whoever carries it will be welcomed at the mill — no swords, no traps, no ambushes. The mill doesn't need clearing, innkeeper. It needs a conversation."
			truth = "That's why I'm here — so the next board gets read between the lines."
	return [
		{"q": "What are you, exactly?", "a": "The mill goblins' ambassador. There — I said it before you had to. We're not raiders, innkeeper. We're refugees. The old mill's been empty since the flood. It has a roof. We have families. No one has been harmed. No one will be."},
		{"q": "Why did you come to me?", "a": "Because you're the neutral ground. The other inns are gone, and the village is afraid, and fear is becoming a war — and wars start with the people who are easiest to fear. I was sent to the one place in the world that listens before it pours." + why},
		{"q": "What do you need?", "a": need},
		{"q": "The board says you're a problem.", "a": "The board said 'goblins in the mill.' The truth was 'families in the mill.' The board is never a lie, innkeeper — it's the shape of a story, seen from far away. " + truth + " The tower's next, isn't it? The board will say 'a door.' It will be right — and that's the terrifying part."},
	]


static func mill_card(mill_state: String) -> Dictionary:
	match mill_state:
		"renn_parley":
			return {"name": "The Mill, at Peace", "tier": "Peace", "tier_color": "8C9A6B",
				"desc": "The village council read the boy's story and the goblins' letter. The mill has a miller again — and this time, everyone knows what they voted for.",
				"reward": "Peace, barley, a story the board never wrote",
				"resolved_text": "Resolved — by a boy with a borrowed sword"}
		"keld_peace":
			return {"name": "The Mill, at Peace", "tier": "Peace", "tier_color": "8C9A6B",
				"desc": "No one is sure how the dwarf did it. The barley moves both ways now. The village pretends it was all their idea.",
				"reward": "Peace, barley, a very quiet dwarf",
				"resolved_text": "Resolved — no one knows how"}
		"woman_dark":
			return {"name": "The Mill, Quiet", "tier": "Quiet", "tier_color": "6B7A8C",
				"desc": "The village names a new miller. No one mentions the goblins. No one mentions her.",
				"reward": "A quiet winter",
				"resolved_text": "Resolved — no one mentions it"}
		_:
			return {"name": "A Parley at the Mill", "tier": "Peace", "tier_color": "8C9A6B",
				"desc": "Grib's letter makes it a conversation. The mill doesn't need clearing — it needs someone brave enough to say so.",
				"reward": "A new regular, a letter, peace",
				"resolved_text": "Going: Grib's letter"}


static func night_two_close(mill_state: String) -> String:
	match mill_state:
		"renn_parley":
			return "You close the inn. The fire settles.\n\nThe village council reads the letter twice. The miller's boy stands there while they do — borrowed sword, muddy boots, no lies.\n\nThree days pass."
		"keld_peace":
			return "You close the inn. The fire settles.\n\nNo one is sure how the dwarf did it. The village doesn't ask. The barley moves, and that's the answer.\n\nThree days pass."
		"woman_dark":
			return "You close the inn. The fire settles.\n\nThe letter is addressed to no one. You keep it anyway, between two hooks on the wall that were waiting.\n\nThree days pass."
		_:
			return "You close the inn. The fire settles.\n\nSomewhere down the road, a letter is being read aloud — carefully, by someone who practiced it in the dark.\n\nThree days pass."


static func grib_regular(mill_state: String, grib: Dictionary) -> String:
	if mill_state == "woman_dark":
		return "On the third day, Grib comes back. He doesn't order. He sets down a thank-you note — very small, very neat — and leaves.\n\nHe comes back the week after anyway. Old habits. Hope.\n\nYou pour him the Sweet. You don't say anything. He doesn't either."
	var middle := ""
	if grib.get("flags", {}).has("poured_sweet"):
		middle = " He sets a small thing on the bar: a candle, barley wax, his own making. 'For the inn. In the books, the inn always has a candle.'"
	elif grib.get("flags", {}).has("poured_bitter"):
		middle = " He doesn't mention the Bitter. You don't either."
	return "On the third day, Grib comes back. Not for business — he sits at the bar and orders a Common, with gratitude." + middle + "\n\n'Thank you for listening,' he says. 'In the books, that's where the story starts.'\n\nHe is the best-dressed regular you will ever have."


# ---------------------------------------------------------------- the window

## The window is the world map. No states, no numbers — the innkeeper's view.
static func window_view(places: Dictionary, flags: Dictionary, guests: Dictionary, batch: String = "") -> String:
	var t := "You wake before the fire. The window, at dawn:\n\n"
	t += _place_line("mill_village", "The mill village", places) + "\n"
	t += _place_line("crossroads", "The crossroads", places) + "\n"
	t += _place_line("forest", "The forest", places) + "\n"
	t += _place_line("deep_road", "The deep road", places) + "\n"
	t += _place_line("tower", "The tower", places) + "\n"
	var flavor := PackedStringArray()
	if flags.has("goblin_peace"):
		flavor.append("The mill turns at night now — first time in years.")
	if flags.has("mill_quiet"):
		flavor.append("The new miller is a good man. He doesn't know what happened to the families. No one will tell him.")
	if flags.has("renn_hat"):
		flavor.append("Somewhere on the road, a boy wears a hat he found. It suits him.")
	if flags.has("silver_too_new"):
		if flags.has("woman_dead"):
			flavor.append("On the bar: a coin, too new. It came back. She didn't.")
		else:
			flavor.append("On the bar: a coin, too new. It bought a round of Common, on the house.")
	if flags.has("woman_dead"):
		flavor.append("On the wall: a sword. There were hooks waiting.")
	if flags.has("renn_dead"):
		flavor.append("On the wall: a sword too big for a boy. It came back. He didn't.")
	if flags.has("keld_knows"):
		flavor.append("Keld knows things now. He drinks, and doesn't say them.")
	if flags.has("keld_dead"):
		flavor.append("On the bar: an axe, and a purse worn by a century of thumbs. He went in alone.")
	if flags.has("bell_key"):
		flavor.append("Somewhere, a key of black iron stays warm.")
	if flags.has("door_watcher"):
		flavor.append("The woman in grey watches the door. She says she'll be there when it opens. You believe her.")
	# The inn remembers how you treated people.
	if guests.has("grib") and guests["grib"]["flags"].has("poured_sweet"):
		flavor.append("Grib's tab is paid in advance, as always. There's a candle on the bar that wasn't there before.")
	if guests.has("grib") and guests["grib"]["flags"].has("poured_bitter"):
		flavor.append("Grib drinks what he's poured and hopes to earn a kinder one. You're working on it.")
	if guests.has("keld") and guests["keld"]["bond"] >= 2:
		flavor.append("At closing, Keld said one sentence about his daughter. Then never again.")
	if batch != "":
		flavor.append("In the cellar, the batch you set is coming along — %s. It smells like next time." % brew_name(batch))
	for f in flavor:
		t += "\n[i]%s[/i]" % f
	return t


static func _place_line(id: String, name: String, places: Dictionary) -> String:
	var lines := {
		"mill_village": {
			"stable": "%s: lights steady under the snow, smoke in straight lines. The mill turns.",
			"strained": "%s: lights lower than last season. The mill is quiet.",
			"failing": "%s: dark at the edges. The lights remember where they were.",
			"fallen": "%s: dark. The window is empty where it was.",
		},
		"crossroads": {
			"stable": "%s: carts, lanterns, voices you can almost hear.",
			"strained": "%s: fewer carts. The dust stays where it settles.",
			"failing": "%s: the dust settles on empty road.",
			"fallen": "%s: the road forgets itself.",
		},
		"forest": {
			"stable": "%s: patient, at the edge of the field.",
			"strained": "%s: closer than it was. You count the fence posts.",
			"failing": "%s: the fence posts are gone. The trees stand where they were.",
			"fallen": "%s: at the window. It taps.",
		},
		"deep_road": {
			"stable": "%s: a cart, a song, someone coming home.",
			"strained": "%s: quiet. The dust remembers the caravan.",
			"failing": "%s: nothing comes. The dark keeps what it takes.",
			"fallen": "%s: dark. The silver that came back was too new.",
		},
		"tower": {
			"stable": "%s: a door, shut. You can feel it stay shut.",
			"strained": "%s: a door. Not the problem. Never was.",
			"failing": "%s: the door breathes. You've heard it.",
			"fallen": "%s: open. The dark comes out to visit.",
		},
	}
	return lines[id][places[id]["state"]] % name


# ---------------------------------------------------------------- weather & the quiet

## docs/06 — the window is the game's weather. Autumn rain, first snow, deep
## winter; the same dark the player has been watching slowly comes to the door.
## And the quiet beats — the fire, the rain, an empty inn as company.

static func window_weather(night: int) -> String:
	match night:
		1:
			return "Soft autumn rain on the roof. The valley lights flicker in the wet."
		2:
			return "The first snow is holding. The road to the mill is white and very quiet."
		_:
			return "Deep winter. The window is nearly dark — the dark you have been watching has come closer, to knock."


static func inn_opening(night: int) -> String:
	return "You light the fire. It catches on the second try, the way it always does.\n\n" + window_weather(night) + "\n\nOutside the door, the night waits. You know, by now, that it isn't only the road out there."


static func quiet_beat(night: int) -> String:
	match night:
		1:
			return "The door settles. The fire pops. You pour yourself a Common and sit a while with the rain — a tired man, an empty room, and the whole night ahead."
		2:
			return "The door settles. Snow drifts against the glass. You pour yourself one and let the inn hold the quiet."
		_:
			return "The door settles. The fire is low. You pour yourself one and sit with the dark, the way the game means you to. It isn't frightening. It's company."


# ---------------------------------------------------------------- night three: the door

## The cellar is a capstone, not a cellar (docs/10 — the locked door). On the
## third night the house opens its question and the answer is the player's own
## history — the mirror runs on world + guest state the innkeeper has been
## quietly keeping (docs/13 — the trial is a conversation, not a battle).

static func _dark_weight(world) -> int:
	var n := 0
	for p in ["mill_village", "crossroads", "forest", "deep_road", "tower"]:
		var s: String = world.state_of(p)
		if s == "failing" or s == "fallen":
			n += 1
	return n


static func _quests_sent(world) -> int:
	var n := 0
	for gid in world.guests.keys():
		for h in world.guests[gid]["history"]:
			if String(h).begins_with("quest "):
				n += 1
	return n


static func _bonds(world) -> int:
	var n := 0
	for gid in world.guests.keys():
		n += world.bond_of(gid)
	return n


static func night_three_open(world) -> String:
	var d: int = _dark_weight(world)
	var t := "A week later, the house is quiet in a way it has never been.\n\n"
	t += "The fire is lit. The regulars are here — the ones who remain.\n"
	if world.has_flag("woman_dead"):
		t += "On the wall, between the hooks that were waiting: her sword. It hums at the cellar door.\n"
	elif world.has_flag("door_watcher"):
		t += "The woman in grey is at the window, watching the road. 'I said I'd be here when it opened,' she says. 'I keep my word.'\n"
	if world.has_flag("renn_dead"):
		t += "On the wall, a sword too big for a boy. It came back. He didn't.\n"
	if world.has_flag("keld_knows") and not world.has_flag("keld_dead"):
		t += "Keld is by the head of the cellar stairs, not quite in the room. 'You know what it is now,' he says. 'You knew when you poured me the Dark.'\n"
	if world.has_flag("keld_dead"):
		t += "On the bar, an axe and a worn coin purse rest where the guard who sat with the whole world used to be. He went in alone.\n"
	if world.has_flag("goblin_peace") or world.has_flag("mill_quiet"):
		t += "Out at the edge of the window, a mill light is steady where it used to be out.\n"
	t += "\nAnd the cellar door is ajar.\n\nIt has never been ajar before. Below it, the dark breathes in the rhythm of a held breath.\n"
	if d == 0:
		t += "\nThe window is clear tonight, and that is the strangest thing of all."
	else:
		t += "\nThe window is a map of it: %d of the places you watch have gone dark." % d
	return t


static func night_three_trial(world) -> String:
	var sent: int = _quests_sent(world)
	var bonds: int = _bonds(world)
	var t := "You take the lamp and go down.\n\nPast the ajar door is not a cellar. It is a boy.\n"
	t += "\nHe is seventeen, the way some boys stay. He is wearing a sword too big for him. He is not surprised to see you.\n"
	t += "\n'You come late,' he says. 'You sent me in, and you never came for me.'\n"
	if sent == 0:
		t += "\n'Except you didn't send anyone, did you? You held the bar, and let the world go dark around you.'\n"
	elif world.has_flag("woman_dead"):
		t += "\n'She paid in silver too new. You knew. You let me walk out with her coin, and the road ate us both.'\n"
	if world.has_flag("renn_dead"):
		t += "\n'The one with the borrowed sword,' he says. 'You poured him the Sweet — to make him generous, to make him loud. He was both. He didn't come back. You knew what the Sweet does to a boy with something to prove.'\n"
	if world.has_flag("keld_dead"):
		t += "\n'The tomb-guard,' he says. 'You poured him the Bitter — made him honest, made him spiteful — and he walked out alone to prove he wasn't wanted. You were the last one who knew the door. Now the door knows.'\n"
	if bonds >= 6:
		t += "\n'But you were kind. I can taste it — the warm pour, the hand that steadied a shaking one. That door is real.'\n"
	elif bonds > 0:
		t += "\n'You read us. You tried. That is more than most who send get.'\n"
	else:
		t += "\n'And you never even learned my name. That is the part that comes to find you.'\n"
	t += "\nHe waits. The door is open. The way through it is not a sword."
	return t


static func night_three_choice(world) -> String:
	return "The room waits. On the bar is the last glass, and beside it, the only thing the whole game has been teaching you to carry: honesty.\n\n'I was afraid. I'm sorry. I'm here now.'\n\nHowever you go through, the inn will remember you by it. The door is yours to answer."


static func sealer_ending(world) -> String:
	var t := "You take the bar-iron and you close the cellar door. You bank the fire low — not out; low is the long way.\n\nThrough the window, the dark withdraws, place by place, the way weather decides to lift.\n\nThe inn settles. The walls stay full of the ones who came back.\n\nYou are the last inn, and you intend to keep being it."
	if world.has_flag("woman_dead"):
		t += "\n\nOn the wall, her sword stays. Some doors you seal from the inside, too."
	return t


static func went_in_ending(world) -> String:
	var t := "You break the vow. You take the old sword off the wall — the one you said you'd never carry again."
	if world.has_flag("woman_dead"):
		t = "You take her sword down — hers, because it waited long enough for someone to carry it. Garrick stands without a word and takes his own. 'About time,' is all he says."
	t += "\n\nYou go down together. The dark is not a battle; it is a question, and you answer it the way you have answered everything tonight: together, at the door, honestly.\n\nYou come back old, whole, and finished. The fire is still burning."
	return t


static func sent_them_ending(world) -> String:
	return "You stand at the head of the stairs and you send them in — the adventurers who came to the last inn. They go down past the ajar door together.\n\nThey come back changed, each carrying a little of the dark out with them, so it stops living only in the cellar.\n\nThe inn keeps burning. You are still behind the bar, still pouring, still reading.\n\nThis is not the wrong ending. It is the ending of the man who stayed, and the game honors it."


# ---------------------------------------------------------------- the regulars

## docs/01, docs/07 — the inn is a living museum of the playthrough. On the
## last night, the regulars who remain are there, and each one reads back how
## they were treated — their quest, their pour, their bond. Absence speaks too.

static func regulars(world, sent: Dictionary) -> Array:
	var out := []
	out.append(_garrick_regular())
	out.append(_fenwick_regular())
	if sent.has("renn") and not world.has_flag("renn_dead"):
		out.append(_renn_regular(world, sent["renn"]))
	if sent.has("keld") and not world.has_flag("keld_dead"):
		out.append(_keld_regular(world))
	if not world.has_flag("woman_dead"):
		out.append(_woman_regular(world))
	return out


static func _garrick_regular() -> Dictionary:
	return {"id": "garrick", "name": "Garrick",
		"line": "He's in his corner, same as the night you first lit the fire. He raises his glass. 'You came back,' he says. 'That's the trick — sitting down when the dark gets close.' He drinks. 'I'll be here when you're ready.'"}


static func _fenwick_regular() -> Dictionary:
	return {"id": "fenwick", "name": "Fenwick",
		"line": "He sweeps his hat off in a bow a little slower than it used to be. 'The last inn, and I the last bard, keeping it honest.' He lets the mask slip for one breath. 'The songs are all true and none of them true — same as the road, same as me. That's why I stay.'"}


static func _renn_regular(world, quest: String) -> Dictionary:
	var line := ""
	match quest:
		"mill":
			line = "Renn is at the bar, wearing a man's name on a boy's shoulders. 'The village's still fighting with the goblins,' he says. 'I'm the only one who talks to both now. You started that — with a pour, not a sword.'"
		"caravan":
			line = "He's at the bar, wearing the hat he found on the road. 'I came back empty,' he says. 'And you didn't hold it against me. That's what made me a man — seeing I could be empty and still count.'"
		_:
			line = "Renn comes back from the tower and does not tell you what he saw. 'The door's not the problem,' he says. 'It never was.' He is older than he was a week ago."
	if world.has_guest_flag("renn", "poured_quiet"):
		line += "\n\n'And the warm one,' he says. 'Nobody ever gave me anything warm before. I'll remember that when the door opens.'"
	return {"id": "renn", "name": "Renn", "line": line}


static func _keld_regular(world) -> Dictionary:
	var line := "Keld is by the wall, the way he was the first night — not quite in the room, exactly where a guard belongs. 'The tower's a door,' he says. 'You knew that. Now you know what's on the other side of it.' He waits long enough to mean it. 'You know what it's for.'"
	if world.has_guest_flag("keld", "poured_dark"):
		line += "\n\n'The Dark,' he says. 'Nobody pours me the Dark. You did. I won't forget it.'"
	return {"id": "keld", "name": "Keld", "line": line}


static func _woman_regular(world) -> Dictionary:
	var line := ""
	if world.has_flag("door_watcher"):
		line = "She is at the window, not the bar. 'I said I'd be here when it opened,' she says. 'I keep my word.' She doesn't turn. 'When you go down, I'll be right behind you.'"
	elif world.has_flag("mill_quiet"):
		line = "She is there and then she isn't — pays, and says nothing, and that silence is the only kindness she has left to give. You let the quiet be."
	else:
		line = "She sits at the bar a long time before she speaks. 'I came for the door,' she says. 'Same as you. Same as it's always been.'"
	return {"id": "woman", "name": "The woman in grey", "line": line}


# ---------------------------------------------------------------- the doorbell

## docs/06 — the bell is the game's one instrument of suspense. Every return
## announces itself with a step the player learns to read: light, heavy,
## measured, or a step that isn't theirs at all.

static func door_bell(guest_id: String, quest_id: String) -> String:
	match guest_id:
		"renn":
			if quest_id == "mill":
				return "Later, a knock — light, almost a tumble, the kind of step that only comes home running."
			return "Later, a knock — light. The step of someone who has been out past dark and is glad to be back under it."
		"keld":
			return "Later, a knock — heavy, deliberate, like a man walking back up from somewhere deep, and meaning every step of it."
		"woman":
			if quest_id == "caravan":
				return "Later, a knock. The step behind it is not hers. That is worse than the knock itself."
			return "Later, a knock — measured, unhurried, a step that has already decided where it is going."
	return "Later, a knock."


## docs/06 — returns arrive one at a time across a quiet montage of days,
## not in a pile. How many days a quest takes before it answers is a tell the
## player learns: the mill answers fast or not at all; the tower keeps its own
## slow hours.
static func return_days(quest_id: String) -> String:
	match quest_id:
		"mill":
			return "The days pass. The mill is the kind of trouble that answers quick, or not at all."
		"caravan":
			return "The days pass. The deep road holds its silence a long while before it gives any of it back."
		_:
			return "The days pass. The tower is not quick about anything — it is a door, and doors keep their own hours."


# ---------------------------------------------------------------- the Sweet pour can lose the boy

## The deepest input is choosing what to pour (docs/05). The Sweet makes a
## person generous *and loud* — sent onto the deep road, that turns a soft
## failure into a loss. The courier brings his sword back; the wall remembers.

static func renn_caravan_courier() -> String:
	return "Five days pass. The door opens.

A stranger stands in the rain, holding a sword too big for a boy — it will never fit him now. He sets it on the bar and does not look at you.

'He said to give this to you. Said you'd know what to do with it.'

You recognize the hilt. It's the borrowed one. The blacksmith's boy never got to give it back."


static func renn_courier_after() -> String:
	return "You hang the sword on the wall. There were hooks waiting.

The fire pops. Out in the wet, the road keeps going, and it does not bring back the ones you read wrong.

[i]The Sweet made him generous. And loud. You knew what it does to a boy with something to prove. You poured it anyway.[/i]"


# ---------------------------------------------------------------- the wall

## The inn is a living museum of the playthrough (docs/01). The wall holds a
## keepsake for every thread the player resolved — a question kept, a loss
## remembered, a kindness that stayed. Walking it is reading your own choices.

static func keepsakes(world) -> Array:
	var out := []
	if world.has_flag("renn_dead"):
		out.append({"name": "A sword too big for a boy",
			"note": "The borrowed one. The blacksmith's boy never got to give it back. It fits the hooks like it was waiting for them."})
	elif world.has_flag("renn_hat"):
		out.append({"name": "A road hat",
			"note": "Renn found it on the deep road and came home wearing it — empty-handed and whole. You let that be enough."})
	if world.has_flag("woman_dead"):
		out.append({"name": "A sword in grey",
			"note": "It came in before she did, kept dry under a stranger's coat. There were hooks waiting."})
	elif world.has_flag("door_watcher"):
		out.append({"name": "A glass by the door",
			"note": "The woman in grey left it. She said she'd be here when the door opened. She keeps her word."})
	if world.has_flag("silver_too_new"):
		out.append({"name": "A coin too new",
			"note": "It bought a round once. It keeps coming back to the bar when you look for it. Some debts stay quiet."})
	if world.has_flag("bell_key"):
		out.append({"name": "A key of black iron",
			"note": "'It's not a lock,' Keld said. 'It's a bell.' He left it warm."})
	if world.has_flag("keld_dead"):
		out.append({"name": "A guard's axe",
			"note": "The stone-hafted axe, and the purse a century of thumbs wore smooth. He went alone because the story made it look like you didn't want him. Some doors close shut from our side."})
	if world.guests.has("grib") and world.guests["grib"]["flags"].has("poured_sweet"):
		out.append({"name": "A barley candle",
			"note": "Grib's thank-you, small and neat. In the books, the inn always has a candle."})
	return out


# ---------------------------------------------------------------- the embers

## docs/10 — after the ending, the Embers: no quests, no board, no stakes. Just
## the inn, the ones who remain, the fire, the rain. You can sit as long as you
## like — or close the inn one last time and walk away, and the game lets you.

static func embers_room() -> String:
	return "The fire burns low. There is nothing left to send — no board, no knock, no door.\n\nOnly the inn: the fire, the beer at the glass, the ones who are still in their chairs.\n\nYou can sit here as long as you like. There is no clock. That is the point."


static func embers_sit() -> String:
	return "You pour yourself one and sit with it.\n\nNobody here needs anything from you now. That is the whole gift of it — for once, no one at this inn needs a thing.\n\nThe fire pops. The rain keeps its slow words at the glass. You are allowed, at last, to be still."


static func final_close() -> String:
	return "You bank the fire down to the last coal. You check the door is shut and the wall is full. You dry the last glass and set it to sleep.\n\nYou close the inn one last time — not from failure, but because you are done, and the game lets you.\n\nThe last kindness."


# ---------------------------------------------------------------- the Bitter pour loses the guard

## Keld reads every room, and the Bitter says 'you want me gone' (docs/05).
## Send him to the caravan after that and he goes alone — the courier brings
## back his axe and the coin he set on the bar before he'd ever trust you.

static func keld_caravan_courier() -> String:
	return "Six days pass. The door opens.\n\nA stranger stands in the doorway, holding an axe — you'd know the stone-hafted head anywhere. At its feet, a small coin purse, leather worn smooth by a century of thumbs.\n\n'He said to give this to you. Said you'd know where it belonged.'\n\nIt's the purse he set on the bar the first night, before he'd ever decided to trust you."


static func keld_courier_after() -> String:
	return "You set the axe and the purse where they can be seen. There were hooks waiting.\n\nThe fire pops. Somewhere, the road he walked has ended.\n\n[i]You poured him the Bitter — 'you want me gone.' He heard you, and he went alone. Some doors close shut from this side.[/i]"
