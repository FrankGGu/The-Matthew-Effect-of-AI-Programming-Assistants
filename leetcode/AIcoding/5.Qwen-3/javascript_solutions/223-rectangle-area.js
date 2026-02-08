function computeArea(A, B, C, D, E, F, G, H) {
    const area1 = (C - A) * (D - B);
    const area2 = (G - E) * (H - F);
    const overlapWidth = Math.max(0, Math.min(C, G) - Math.max(A, E));
    const overlapHeight = Math.max(0, Math.min(D, H) - Math.max(B, F));
    const overlapArea = overlapWidth * overlapHeight;
    return area1 + area2 - overlapArea;
}