package com.pkd;

// 소음을 평가(판단)하는 클래스
public class NoiseEvaluation implements Evaluation {
    Noise noise;
    EvaluationWay evaluationWay;

    public NoiseEvaluation(Noise noise, EvaluationWay evaluationWay) {
        this.noise = noise;
        this.evaluationWay = evaluationWay;
    }

    @Override
    public String evaluate() {
        if (evaluationWay.calculate()) {
            return noise.Silent();
        } else {
            return noise.Noisy();
        }
    }
}
