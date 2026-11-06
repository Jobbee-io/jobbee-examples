<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Online picking capacity during the first lockdown

Corriemoor Partners, for a UK grocer (a different client from my cost programme). April – June 2020, 10 weeks, as a Business Analyst. On my resume it's one bullet under my analyst years. It's a small project, but it was the first model I built that decided where real capacity went, week by week.

## The full story

In April 2020, in the first lockdown, the client's online orders outran its delivery slots within days. Orders were picked from the shelves of about 300 stores, and nobody knew which stores could take more. The team was an engagement manager, a consultant working on vans with the client's transport team, and me. I built the store-by-store capacity model. The client's online operations team decided where the slots went, and did the hiring, rota changes and store set-up.

The model took the lowest of 4 limits for each store: picker hours, pick rate, holding space and van slots. Holding space wasn't in any system, so I wrote a 6-question form for store managers, and 284 came back in 4 days. I refreshed the model every Monday, and it ranked stores by how fast their limit could be lifted.

It went wrong twice. In week 3, 2 stores ran out of chilled space for waiting orders, and the client had to cut their slots back. I had treated holding space as one number, so from week 4 the model split it into ambient, chilled and frozen. In week 5 I found that pick rates had fallen about 15%, because pickers spent longer on substitutions. I had used pre-lockdown rates, so for a month the model overstated capacity in the busiest stores.

By week 10, 210 stores were taking extra slots, and weekly slots had grown from about 250,000 to about 400,000. That's the client's figure, and most of it is their operations teams' work. The engagement ended in June 2020 with the tenth weekly version of the model. Nothing was left open on my side. I don't know how long the client kept using the model after that.

## What it was

In the first lockdown, online orders outran delivery slots within days. The client picked online orders from the shelves of about 300 stores. It needed to know which stores could take more slots, and what was stopping the rest. The team was an engagement manager, a consultant who worked on vans with the client's transport team, and me. The client's online operations team decided slot allocation and did the hiring, rota changes and store set-up. That was the hard part.

## My part: the capacity model

I built a store-by-store model in Excel. For each store, weekly slot capacity was the lowest of 4 limits:

- Picker hours: hours available for picking, from rotas, including store colleagues moved onto picking.
- Pick rate: items picked per picker-hour, from the client's picking system, turned into orders using the average items per order.
- Holding space: room in the back of the store for picked orders waiting for a van.
- Van slots: from the transport model my colleague ran.

The model showed which limit bound each store, and ranked stores by how quickly that limit could be lifted. Stores limited only by picker hours came first, because moving colleagues onto picking took days and new vans took weeks.

Holding space wasn't in any system. I wrote a 6-question form for store managers, and 284 of about 300 came back within 4 days. The model was refreshed every Monday, 10 versions in all.

## The numbers

- Weekly delivery and collection slots offered, from the client's slot system: about 250,000 to about 400,000 in 10 weeks, roughly 60%. That's the client's figure, and most of it is their operations teams' work.
- Stores taking extra slots: 140 in the first 4 weeks, 210 by week 10.

## What went wrong

- I treated holding space as one number. In week 3, 2 stores ran out of chilled space for waiting orders and the client had to cut their slots back. From week 4 the model split holding space into ambient, chilled and frozen, and I re-ran the form with those questions.
- I used pre-lockdown pick rates until week 5. With gaps on the shelves, pickers spent longer on substitutions, and rates had fallen about 15%. The model overstated capacity in the busiest stores for a month.

## What I'd do differently

- Ask store managers what limits them before building the model, not after it breaks.
- Check every input measured in normal times against what's happening now.
