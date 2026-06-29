# Travel Planner Design Language

## Visione

Travel Planner deve sembrare un compagno di viaggio: semplice, ordinato, moderno e piacevole da usare.

## Principi UX

- Prima le informazioni importanti.
- Ogni schermata deve avere una gerarchia chiara.
- Ogni azione importante deve essere evidente.
- Niente elementi superflui.
- L'interfaccia deve trasmettere calma e organizzazione.

## Palette colori

- Primary: Indigo
- Secondary: Teal
- Success: Green
- Warning: Orange
- Error: Red
- Background: #F7F8FA
- Surface: White

## Tipografia

- Hero: 32
- Title: 26
- Section: 20
- Body: 16
- Caption: 13

## Spacing

- xs: 4
- sm: 8
- md: 16
- lg: 24
- xl: 32
- xxl: 48

## Border Radius

- sm: 8
- md: 12
- lg: 20
- xl: 28
- pill: 999

## Ombre

Le card devono usare ombre leggere, morbide e poco invadenti.

## Componenti UI

- AppCard
- AppButton
- AppSection
- AppBadge
- AppEmptyState
- AppTextField

## Iconografia

- ✈️ Viaggi
- 📍 Tappe
- 🏨 Hotel
- 🚗 Trasporti
- 💰 Budget
- 📄 Documenti
- 📷 Foto

## Regole di progettazione

- Usare sempre AppSpacing per gli spazi.
- Usare sempre AppRadius per gli angoli.
- Usare AppCard invece di Card dove possibile.
- Usare AppButton invece di FilledButton dove possibile.
- Evitare colori hardcoded quando possibile.

## Esempi di schermate

### Home

Header → Hero Card → Dashboard → Lista viaggi

### Dettaglio viaggio

Header viaggio → Timeline → Sezioni funzionali