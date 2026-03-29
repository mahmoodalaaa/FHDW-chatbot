# Dokumentation: FHDW KI-Chatbot zur Karriereberatung

Dieses Repository enthält den Quellcode für ein softwarebasiertes System zur automatisierten Karriereberatung für Studierende und Schüler. Die Anwendung nutzt Methoden der Künstlichen Intelligenz (KI), um individuelle Karrierepfade auf Basis von Nutzerinteressen und Qualifikationsprofilen zu identifizieren und zu evaluieren.

## 1. Projektbeschreibung und Zielsetzung

Die primäre Zielsetzung des Projekts ist die Entwicklung eines skalierbaren Beratungswerkzeugs, das den Prozess der Berufsfindung durch den Einsatz moderner Sprachmodelle optimiert. Im Kontext der FHDW (Fachhochschule der Wirtschaft) fungiert die Anwendung als digitaler Assistent, der eine Brücke zwischen akademischer Ausbildung und dem Arbeitsmarkt schlägt.

Durch die Integration von Natural Language Processing (NLP) ist das System in der Lage, komplexe Nutzeranfragen zu interpretieren und kontextsensitive Empfehlungen auszusprechen, die über einfache Keyword-Suchen hinausgehen.

## 2. Funktionaler Umfang

Das System umfasst mehrere spezialisierte Module, die eine ganzheitliche Karriereberatung ermöglichen:

- **Konversationsbasierte Wissensvermittlung:** Ein Chat-Interface, das auf der GPT-4-Architektur basiert und fundierte Antworten auf Fragen zu Studienverläufen, Berufsfeldern und Karrierevoraussetzungen liefert.
- **Interessenbasierte Profilanalyse (Quiz-Modul):** Eine strukturierte Datenerfassung, die es ermöglicht, die Neigungen und Fähigkeiten des Nutzers systematisch zu erfassen.
- **Algorithmische Job-Evaluation:** Nach Abschluss der Datenaufnahme generiert das System detaillierte Jobprofile. Diese beinhalten eine prozentuale Übereinstimmung (Match Percentage), voraussichtliche Gehaltsstrukturen, Marktwachstumsprognosen sowie eine detaillierte Aufschlüsselung täglicher Aufgabenbereiche.
- **Persistenz von Empfehlungen:** Eine Speicherfunktion ermöglicht es den Nutzern, identifizierte Karrierepfade dauerhaft in einem individuellen Profil zu hinterlegen.

## 3. Technische Architektur

Die Software ist als Cross-Platform-Applikation konzipiert, wobei eine strikte Trennung zwischen Präsentationsschicht, Geschäftslogik und Datenmodellierung eingehalten wurde.

### 3.1 Framework und Programmiersprache
Die Anwendung wurde mit dem Flutter-Framework (Dart) realisiert. Dies ermöglicht eine performante Ausführung auf verschiedenen Betriebssystemen bei gleichzeitiger Wahrung einer konsistenten Codebasis.

### 3.2 Architekturmuster: MVVM (Model-View-ViewModel)
Die Softwarearchitektur folgt konsequent dem **MVVM-Schema**, um eine hohe Wartbarkeit und Testbarkeit zu gewährleisten:

- **Model:** Repräsentiert die reinen Datenstrukturen der Anwendung. Hierzu gehören Entitäten wie `JobRecommendation`, `UserProfile` und `ChatMessage`. Diese Schicht ist unabhängig von der Benutzeroberfläche und enthält keine Geschäftslogik.
- **View:** Umfasst alle UI-Komponenten (Screens und Widgets). Die View reagiert ausschließlich auf Zustandsänderungen des ViewModels und leitet Nutzerinteraktionen an dieses weiter.
- **ViewModel (AppState):** Fungiert als Bindeglied zwischen Daten und Anzeige. Es kapselt die gesamte Geschäftslogik (z. B. die Verarbeitung der Quiz-Antworten oder die Kommunikation mit der KI-API) und hält den aktuellen Anwendungszustand vor.

### 3.3 Zustandsverwaltung (State Management)
Die Synchronisation zwischen dem ViewModel und der View wird über das **Provider-Paket** in Kombination mit dem **ChangeNotifier-Pattern** realisiert:

- Der `AppState` (das zentrale ViewModel) erbt von der Klasse `ChangeNotifier`.
- Bei jeder relevanten Datenänderung (z. B. Eintreffen einer KI-Antwort oder Markierung einer Favoritenstelle) wird die Methode `notifyListeners()` aufgerufen.
- Die betroffenen UI-Komponenten (Consumer) werden automatisch über diese Änderung informiert und bauen sich effizient neu auf (Reactive UI).

### 3.4 KI-Integration und Prompt-Engineering
Die Intelligenz des Systems basiert auf der Integration der OpenAI API (GPT-4o-mini). Ein wesentlicher Bestandteil der technischen Umsetzung ist das Design spezialisierter System-Prompts, die sicherstellen, dass die KI als professioneller Karriereberater fungiert und strukturierte Datenformate (JSON) für die technische Weiterverarbeitung liefert.

## 4. Projektstruktur und Datei-Organisation

Die Verzeichnisstruktur spiegelt die MVVM-Architektur wider und ist wie folgt gegliedert:

- **lib/models/**: Entspricht der **Model-Schicht**. Definition der Datenmodelle, die eine standardisierte Repräsentation von Berufsfeldern und Nutzerdaten sicherstellen.
- **lib/providers/**: Entspricht der **ViewModel-Schicht**. Beinhaltet die zentrale Logik der Zustandsverwaltung (`app_state.dart`).
- **lib/screens/**: Entspricht der **View-Schicht**. Beinhaltet die UI-Module:
    - `chatbot_screen.dart`: Schnittstelle zur KI-Kommunikation.
    - `dashboard_screen.dart`: Zentrale Aggregation von Nutzerinformationen.
    - `quiz_screen.dart`: Logik zur Erhebung des Interessenprofils.
    - `result_screen.dart`: Visualisierung der KI-generierten Analyseergebnisse.
- **lib/services/**: Kapselung der **Service-Schicht**. Enthält isolierte Logik für externe API-Aufrufe (OpenAIService), um die Testbarkeit zu erhöhen.
- **lib/theme/**: Definition der visuellen Ästhetik (Farbsystem, Typografie), basierend auf den CI-Vorgaben der FHDW.
- **main.dart**: Primärer Einstiegspunkt des Systems und Initialisierung des globalen Providers.

## 5. Systemanforderungen und Installation

### Voraussetzungen
- Flutter SDK (aktuelle Version)
- Gültiger API-Schlüssel für OpenAI
- Konfigurationsdatei `.env` im Stammverzeichnis

### Installationsprozess
1. Klonen des Repositories.
2. Installation der benötigten Plug-ins mittels `flutter pub get`.
3. Hinterlegung des API-Keys in der `.env`-Datei unter der Variable `OPENAI_API_KEY`.
4. Kompilierung und Ausführung der Applikation über `flutter run`.

## 6. Zusammenfassung und Ausblick
Dieses Projekt demonstriert das Potenzial generativer KI-Modelle in der akademischen Beratungslandschaft. Durch die strukturierte Aufbereitung von Berufsdaten wird eine fundierte Entscheidungsgrundlage für die individuelle Karriereplanung geschaffen. Zukünftige Erweiterungen könnten die Integration lokaler Arbeitsmarktdaten oder eine direkte Anbindung an Hochschulinformationssysteme beinhalten.
