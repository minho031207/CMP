# Chips Master Program (CMP): AI Semiconductor Device & Process Optimization

### Project Objective: Addressing Modern Semiconductor Challenges via Data-Driven Device Design
This project is part of the **Chips Master Program (CMP)**, an intensive long-term initiative dedicated to bridging academic theory with industrial requirements in AI semiconductor device and process integration.

---

## 1. Program Overview (프로그램 개요)

CMP(Chips Master Program)는 첨단분야 혁신융합대학사업단과 숭실대 차세대반도체학과가 운영하는 실무 중심의 장기 프로젝트 프로그램입니다.

* **활동 기간:** 2026.04 ~ 2027.01
* **핵심 목표:** AI 반도체의 기술적 난제(Bottleneck)를 파악하고, 시뮬레이션 기반 소자 설계 프로젝트를 통해 최적화된 설계 결과물 도출.
* **주요 활동:** 이론 습득, 산업체 실무 요구사항 파악(기업 견학 및 탐방), TCAD 시뮬레이션 프로젝트 수행.

---

## 2. Topic Selection Process (주제 선정 과정)

### 2.1 주제: 20nm급 BCAT DRAM에서의 GIDL 누설 전류 저감 최적화 설계
* **선정 배경:** 미세화(Scaling)에 따른 Trench Corner 부근의 고전계(E-field) 집중 및 대역간 터널링(BTBT) 현상으로 인한 DRAM Cell의 '리프레시 특성 불량' 문제 해결.
* **기술적 접근:** Trench 깊이, LDD/Halo Implant 공정 변수 조절을 통해 누설 전류 제어 및 설계 최적화.

*   **[주제 발표 자료(PDF)](CMP_소자공정_송민호(재발표).pdf)**

### 2.2 교수 피드백 및 고도화 과제 (Core Feedback & Improvement)
주제 발표 이후, 소자의 물리적 분석력을 강화하고 시뮬레이션의 정밀도를 높이기 위해 다음과 같은 추가 과제를 부여받았습니다. 본 프로젝트는 해당 피드백을 핵심 개선 사항으로 반영하여 수행합니다.

> **주요 피드백 사항**
> 1. **변수 확장:** 기존 설계 변수에 GIDL의 주요 변수인 **MEB(Metal-to-Epitaxial/Buried) Depth**를 추가하여 정밀도 향상.
> 2. **핵심 파라미터 측정:** 설계 최적화의 척도로서 Cov (Gate-to-Si 계면의 Overlap Capacitance)를 시뮬레이션하여 데이터화할 것.

* **고도화 방향:** 위 피드백을 바탕으로 TCAD 시뮬레이션 내에서 $C_{ov}$와 GIDL 특성 간의 상관관계를 정량적으로 도출하고, 이를 바탕으로 최적의 공정 마진을 확보할 계획입니다.

### 2.3 연구 진행을 위한 작업 현황 (Work In Progress)
본 섹션은 프로젝트가 진행됨에 따라 시뮬레이션 결과와 분석 자료를 순차적으로 업데이트할 예정입니다.

> **[프로젝트 작업 공간]**
> * 현재 시뮬레이션 환경(TCAD) 구축 및 변수 최적화 단계입니다.
> * 향후 분석 데이터와 구조 분석 도표가 이곳에 업데이트됩니다.
>   * *Phase 1: 시뮬레이션 모델 검증 및 기본 특성 확보*
>   * *Phase 2: 공정 변수(Trench Depth 등) 스윕 결과 및 최적화 데이터*
>   * *Phase 3: 물리적 고찰 및 최종 설계 사양 도출*

---

## 3. Project Roadmap (향후 계획)

* **시뮬레이션 환경 구축:** Synopsys TCAD 기반 물리 모델(BandToBand) 활성화 및 가혹 환경(380K) 모사.
* **정량적 변수 스윕(Sweep):** 구조 및 공정 변수의 정량적 최적화 수행.
* **데이터 검증:** Mesh Refinement를 통한 수렴성 확보 및 현업 수준의 특성값 도출.

---
