# 32 — Swift Recreation of 126

## Overview

**32** is a **100% native Swift / SwiftUI** recreation of the **126** app, which is currently built as a **Vite-based web application**.

The goal of this repository is to rebuild **every screen, feature, and behavior** from the 126 app so that:

- The **UI looks identical**
- The **features are functionally equivalent**
- The **user experience matches as closely as possible**
- Both apps ultimately share the **same Supabase backend**

This repo is **not an experimental rewrite** — it is a **1:1 native implementation**.

---

## Relationship to 126

| Repo | Platform | Purpose |
|----|----|----|
| **126** | Web (Vite) | Source of truth for UI, flows, and features |
| **32** | iOS (Swift / SwiftUI) | Native recreation of 126 |

**126 defines what the app is.**  
**32 mirrors it natively.**

If a feature exists in 126, it **must exist here**.

---

## Core Goals

- ✅ Pixel-matched UI between web and iOS  
- ✅ Identical navigation structure  
- ✅ Identical business logic and workflows  
- ✅ Shared Supabase backend (auth, data, RLS)  
- ✅ No feature divergence between platforms  

---

## Architecture Plan

### Frontend
- **Swift / SwiftUI**
- Native navigation, animations, and interactions
- iOS-appropriate components while maintaining visual parity

### Backend
- **Supabase (shared with 126)**
- Same tables, schemas, RLS policies, and logic
- One backend powering both platforms

---

## Development Rules

- ❌ Do **not** invent new features that don’t exist in 126  
- ❌ Do **not** redesign UI unless required by iOS constraints  
- ✅ Follow 126 layouts, spacing, naming, and flows exactly  
- ✅ Treat 126 as the visual and functional reference  

---

## Current Status

- 🔄 Initial Swift project setup
- 🔄 UI and feature parity work in progress
- 🔒 Backend integration will match 126 when connected

---

## Long-Term Vision

- Web (126) and iOS (32) run side-by-side
- Same users, same data, same behavior
- Platform-native experiences with **zero feature gaps**

---

## Notes

This repo intentionally mirrors another codebase.  
Duplication is **by design** to achieve platform-native performance while preserving consistency.

---
