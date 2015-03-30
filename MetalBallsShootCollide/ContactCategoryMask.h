typedef NS_OPTIONS(uint32_t, CollisionCategory) {
    CategoryWall = 1 << 0,
    CategoryTarget = 1 << 1,
    CategoryBall = 1 << 2,
    CategoryInvisibleTarget = 1 << 3,
    CategoryPowerUp = 1 << 4
};
