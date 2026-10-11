---
title: solo-automation — Product Card
doc_id: CARD-solo-automation
doc_type: product-card
verdict: invest
version: 0.1
date: 2026-10-11
status: ร่างเพื่อพิจารณา
owner: Product owner (Book Dev)
---

# solo-automation — Product Card

## 1. สรุปคุณค่าในหนึ่งประโยค

เก็บนิยามงานอัตโนมัติ (cron job, rule, pipeline) และ log การทำงานไว้ใน API/DB ของตัวเอง เพื่อให้ agent และเจ้าของตรวจสอบได้ว่ามีอะไรรันอยู่

## 2. ปัญหาและผู้ใช้เป้าหมาย

นิยามงานอัตโนมัติเคยอยู่ใน SQLite ในเครื่องเดียว ไม่มีสิทธิ์/audit กลาง; ผู้ใช้คือเจ้าของและ agent ของ Solo Empire

## 3. สิ่งที่ทำได้จริงตอนนี้

- REST `/v1/cron-jobs`, `/v1/automation-rules`, `/v1/workflow-pipelines`, `/v1/automation-log` พร้อมตัวกรองตาม README
- คำสั่ง `automation-db provision` สร้าง Neon DB; migrations ใน `migrations/`
- ทุกการเขียนผ่านลำดับ precheck → เปลี่ยนข้อมูลในเครื่อง → execution บน empire-platform → commit → finish พร้อม row hash และ RLS แบบบังคับต่อ workspace (ตาม README)

## 4. หลักฐานสถานะ

| รายการ | ค่า |
|---|---|
| Stack | Python, FastAPI, PostgreSQL (Neon) |
| Commit | 2 ครั้ง (2026-10-10 ถึง 2026-10-11) |
| ซอร์สโค้ด | 15 ไฟล์ / 2208 บรรทัด |
| เทสต์ | 2 ไฟล์ (ไม่ได้รันในงานนี้) |
| CI | ไม่มี workflow |
| Deploy config | Railway (Serverless) + Neon; ทะเบียน `online-systems.yaml` ระบุสถานะ online (ไม่ได้ probe สดในงานนี้) |
| Live URL | ดูทะเบียน `online-systems.yaml` (ไม่ได้ probe สด) |

## 5. คุณค่าและจุดต่าง

- เป็นส่วนหนึ่งของสถาปัตยกรรม decentralize ที่ 1 domain = 1 cell จึงเปลี่ยนหรือขายแยกได้
- ใช้สิทธิ์/audit กลางร่วมกันโดยไม่ต้องเขียนใหม่ต่อ cell
- **[สมมติฐาน]** มูลค่าเชิงรายได้ยังไม่พิสูจน์ — ใช้เป็นระบบของเจ้าของก่อน

## 6. ช่องว่างสำคัญ

- พึ่ง empire-platform ตัวเดียว: ถ้า platform ล่ม cell เขียนไม่ได้ (fail closed)
- cell เก็บ **นิยาม/log** ไม่ใช่ตัวรันงาน — ตัวรันจริงต้องยืนยันว่าอยู่ที่ใด **[ต้องยืนยัน]**
- เทสต์มี 2 ไฟล์ (เป็นเทสต์ contract ที่ kit สร้าง)

## 7. คำตัดสิน

**`invest`** — เป็นแกนข้อมูลของ domain ที่ระบบ Solo Empire ใช้จริงและตาม cell contract เดียวกัน จะเปลี่ยนเป็น `showcase` หากเจ้าของยุบ domain นี้หรือย้ายไปรวมกับ cell อื่น

## 8. ขั้นต่อไป

1. ระบุว่า cron/pipeline ใดอ่านนิยามจาก cell นี้จริง
2. เพิ่มเทสต์เฉพาะ domain นอกเหนือจาก contract

## การอนุมัติ

| บทบาท | สถานะ | วันที่ | ลงนาม |
|---|---|---|---|
| Product owner (Book Dev) | รอพิจารณา | — | ________ |

## แหล่งข้อมูล

- `README.md`
- `cell.yaml`
- `tests/`
