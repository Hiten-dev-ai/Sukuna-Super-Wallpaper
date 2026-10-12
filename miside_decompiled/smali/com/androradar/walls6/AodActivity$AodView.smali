.class public Lcom/androradar/walls6/AodActivity$AodView;
.super Landroid/view/View;
.source "AodActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/androradar/walls6/AodActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "AodView"
.end annotation


# instance fields
.field private mBatteryPaint:Landroid/graphics/Paint;

.field private mDateFormat:Ljava/text/SimpleDateFormat;

.field private mFodPaint:Landroid/graphics/Paint;

.field private mSubTextPaint:Landroid/graphics/Paint;

.field private mSukunaBitmap:Landroid/graphics/Bitmap;

.field private mTextPaint:Landroid/graphics/Paint;

.field private mTimeFormat:Ljava/text/SimpleDateFormat;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 4

    .line 221
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 222
    const/high16 v0, -0x1000000

    invoke-virtual {p0, v0}, Lcom/androradar/walls6/AodActivity$AodView;->setBackgroundColor(I)V

    .line 225
    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object p1

    const-string v0, "sukuna_aod.png"

    invoke-virtual {p1, v0}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p1

    .line 226
    invoke-static {p1}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v0

    iput-object v0, p0, Lcom/androradar/walls6/AodActivity$AodView;->mSukunaBitmap:Landroid/graphics/Bitmap;

    .line 227
    invoke-virtual {p1}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 230
    goto :goto_0

    .line 228
    :catch_0
    move-exception p1

    .line 229
    const/4 p1, 0x0

    iput-object p1, p0, Lcom/androradar/walls6/AodActivity$AodView;->mSukunaBitmap:Landroid/graphics/Bitmap;

    .line 232
    :goto_0
    new-instance p1, Ljava/text/SimpleDateFormat;

    const-string v0, "HH:mm"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    invoke-direct {p1, v0, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    iput-object p1, p0, Lcom/androradar/walls6/AodActivity$AodView;->mTimeFormat:Ljava/text/SimpleDateFormat;

    .line 233
    new-instance p1, Ljava/text/SimpleDateFormat;

    const-string v0, "EEE, MMM d"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    invoke-direct {p1, v0, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    iput-object p1, p0, Lcom/androradar/walls6/AodActivity$AodView;->mDateFormat:Ljava/text/SimpleDateFormat;

    .line 235
    new-instance p1, Landroid/graphics/Paint;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object p1, p0, Lcom/androradar/walls6/AodActivity$AodView;->mTextPaint:Landroid/graphics/Paint;

    .line 236
    const/4 v1, -0x1

    invoke-virtual {p1, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 237
    iget-object p1, p0, Lcom/androradar/walls6/AodActivity$AodView;->mTextPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {p1, v1}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 238
    iget-object p1, p0, Lcom/androradar/walls6/AodActivity$AodView;->mTextPaint:Landroid/graphics/Paint;

    const-string v1, "sans-serif-medium"

    const/4 v2, 0x0

    invoke-static {v1, v2}, Landroid/graphics/Typeface;->create(Ljava/lang/String;I)Landroid/graphics/Typeface;

    move-result-object v3

    invoke-virtual {p1, v3}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 240
    new-instance p1, Landroid/graphics/Paint;

    invoke-direct {p1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object p1, p0, Lcom/androradar/walls6/AodActivity$AodView;->mSubTextPaint:Landroid/graphics/Paint;

    .line 241
    const v3, -0x4c000001

    invoke-virtual {p1, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 242
    iget-object p1, p0, Lcom/androradar/walls6/AodActivity$AodView;->mSubTextPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {p1, v3}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 243
    iget-object p1, p0, Lcom/androradar/walls6/AodActivity$AodView;->mSubTextPaint:Landroid/graphics/Paint;

    const-string v3, "sans-serif"

    invoke-static {v3, v2}, Landroid/graphics/Typeface;->create(Ljava/lang/String;I)Landroid/graphics/Typeface;

    move-result-object v3

    invoke-virtual {p1, v3}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 245
    new-instance p1, Landroid/graphics/Paint;

    invoke-direct {p1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object p1, p0, Lcom/androradar/walls6/AodActivity$AodView;->mBatteryPaint:Landroid/graphics/Paint;

    .line 246
    const v3, -0x33000001    # -1.3421772E8f

    invoke-virtual {p1, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 247
    iget-object p1, p0, Lcom/androradar/walls6/AodActivity$AodView;->mBatteryPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {p1, v3}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 248
    iget-object p1, p0, Lcom/androradar/walls6/AodActivity$AodView;->mBatteryPaint:Landroid/graphics/Paint;

    invoke-static {v1, v2}, Landroid/graphics/Typeface;->create(Ljava/lang/String;I)Landroid/graphics/Typeface;

    move-result-object v1

    invoke-virtual {p1, v1}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 250
    new-instance p1, Landroid/graphics/Paint;

    invoke-direct {p1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object p1, p0, Lcom/androradar/walls6/AodActivity$AodView;->mFodPaint:Landroid/graphics/Paint;

    .line 251
    return-void
.end method


# virtual methods
.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 17

    .line 255
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    invoke-super/range {p0 .. p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    .line 256
    invoke-virtual/range {p0 .. p0}, Lcom/androradar/walls6/AodActivity$AodView;->getWidth()I

    move-result v3

    .line 257
    invoke-virtual/range {p0 .. p0}, Lcom/androradar/walls6/AodActivity$AodView;->getHeight()I

    move-result v0

    .line 258
    if-eqz v3, :cond_b

    if-nez v0, :cond_0

    goto/16 :goto_8

    .line 261
    :cond_0
    iget-object v4, v1, Lcom/androradar/walls6/AodActivity$AodView;->mSukunaBitmap:Landroid/graphics/Bitmap;

    const/4 v5, 0x0

    const/4 v6, 0x0

    if-eqz v4, :cond_1

    .line 262
    new-instance v4, Landroid/graphics/Rect;

    iget-object v7, v1, Lcom/androradar/walls6/AodActivity$AodView;->mSukunaBitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v7

    iget-object v8, v1, Lcom/androradar/walls6/AodActivity$AodView;->mSukunaBitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v8}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v8

    invoke-direct {v4, v6, v6, v7, v8}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 263
    new-instance v7, Landroid/graphics/Rect;

    invoke-direct {v7, v6, v6, v3, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 264
    iget-object v8, v1, Lcom/androradar/walls6/AodActivity$AodView;->mSukunaBitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v2, v8, v4, v7, v5}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    .line 268
    :cond_1
    new-instance v4, Ljava/util/Date;

    invoke-direct {v4}, Ljava/util/Date;-><init>()V

    .line 269
    iget-object v7, v1, Lcom/androradar/walls6/AodActivity$AodView;->mTextPaint:Landroid/graphics/Paint;

    int-to-float v8, v3

    const v9, 0x3e23d70a    # 0.16f

    mul-float v9, v9, v8

    invoke-virtual {v7, v9}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 270
    int-to-float v7, v0

    const v0, 0x3e3851ec    # 0.18f

    mul-float v0, v0, v7

    .line 271
    iget-object v9, v1, Lcom/androradar/walls6/AodActivity$AodView;->mTimeFormat:Ljava/text/SimpleDateFormat;

    invoke-virtual {v9, v4}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v9

    const/high16 v10, 0x40000000    # 2.0f

    div-float v10, v8, v10

    iget-object v11, v1, Lcom/androradar/walls6/AodActivity$AodView;->mTextPaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v9, v10, v0, v11}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 274
    iget-object v9, v1, Lcom/androradar/walls6/AodActivity$AodView;->mSubTextPaint:Landroid/graphics/Paint;

    const v11, 0x3d2c0831    # 0.042f

    mul-float v11, v11, v8

    invoke-virtual {v9, v11}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 275
    const v9, 0x3da3d70a    # 0.08f

    mul-float v9, v9, v8

    add-float v11, v0, v9

    .line 276
    iget-object v0, v1, Lcom/androradar/walls6/AodActivity$AodView;->mDateFormat:Ljava/text/SimpleDateFormat;

    invoke-virtual {v0, v4}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    iget-object v4, v1, Lcom/androradar/walls6/AodActivity$AodView;->mSubTextPaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v0, v10, v11, v4}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 279
    nop

    .line 280
    nop

    .line 282
    const/4 v4, 0x5

    const/4 v12, 0x2

    const/4 v13, 0x1

    const/4 v14, -0x1

    :try_start_0
    new-instance v0, Landroid/content/IntentFilter;

    const-string v15, "android.intent.action.BATTERY_CHANGED"

    invoke-direct {v0, v15}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 283
    invoke-virtual/range {p0 .. p0}, Lcom/androradar/walls6/AodActivity$AodView;->getContext()Landroid/content/Context;

    move-result-object v15

    invoke-virtual {v15, v5, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    move-result-object v0

    .line 284
    if-eqz v0, :cond_4

    .line 285
    const-string v5, "level"

    invoke-virtual {v0, v5, v14}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v5

    .line 286
    const-string v15, "scale"

    invoke-virtual {v0, v15, v14}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v15
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 287
    int-to-float v5, v5

    int-to-float v15, v15

    div-float/2addr v5, v15

    const/high16 v15, 0x42c80000    # 100.0f

    mul-float v5, v5, v15

    float-to-int v5, v5

    .line 288
    :try_start_1
    const-string v15, "status"

    invoke-virtual {v0, v15, v14}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 289
    if-eq v0, v12, :cond_3

    if-ne v0, v4, :cond_2

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    goto :goto_1

    :cond_3
    :goto_0
    const/4 v0, 0x1

    :goto_1
    move v14, v5

    goto :goto_2

    .line 291
    :catch_0
    move-exception v0

    move v14, v5

    goto :goto_3

    .line 284
    :cond_4
    const/4 v0, 0x0

    .line 291
    :goto_2
    goto :goto_4

    :catch_1
    move-exception v0

    :goto_3
    const/4 v0, 0x0

    .line 293
    :goto_4
    const v5, 0x3d8f5c29    # 0.07f

    mul-float v5, v5, v8

    add-float/2addr v11, v5

    .line 294
    iget-object v5, v1, Lcom/androradar/walls6/AodActivity$AodView;->mBatteryPaint:Landroid/graphics/Paint;

    const v15, 0x3d1ba5e3    # 0.038f

    mul-float v15, v15, v8

    invoke-virtual {v5, v15}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 295
    const-string v5, ""

    if-ltz v14, :cond_6

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz v0, :cond_5

    const-string v5, "\u26a1 "

    :cond_5
    invoke-virtual {v15, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, "%"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 296
    :cond_6
    iget-object v0, v1, Lcom/androradar/walls6/AodActivity$AodView;->mBatteryPaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v5, v10, v11, v0}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 300
    :try_start_2
    invoke-static {}, Lcom/androradar/walls6/AodNotificationListener;->getActiveAlerts()Ljava/util/List;

    move-result-object v0

    .line 301
    if-eqz v0, :cond_a

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_a

    .line 302
    invoke-virtual/range {p0 .. p0}, Lcom/androradar/walls6/AodActivity$AodView;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v5

    .line 303
    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10}, Ljava/util/ArrayList;-><init>()V

    .line 304
    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14}, Ljava/util/ArrayList;-><init>()V

    .line 306
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v15

    :goto_5
    invoke-interface {v15}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_9

    invoke-interface {v15}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/service/notification/StatusBarNotification;

    .line 307
    invoke-virtual {v0}, Landroid/service/notification/StatusBarNotification;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .line 308
    invoke-interface {v14, v0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v16

    if-eqz v16, :cond_7

    goto :goto_5

    .line 309
    :cond_7
    invoke-interface {v14, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_3

    .line 311
    :try_start_3
    invoke-virtual {v5, v0}, Landroid/content/pm/PackageManager;->getApplicationIcon(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 312
    invoke-interface {v10, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 313
    invoke-interface {v10}, Ljava/util/List;->size()I

    move-result v0
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    if-lt v0, v4, :cond_8

    goto :goto_6

    .line 314
    :catch_2
    move-exception v0

    :cond_8
    nop

    .line 315
    goto :goto_5

    .line 317
    :cond_9
    :goto_6
    :try_start_4
    invoke-interface {v10}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_a

    .line 318
    const v0, 0x3d851eb8    # 0.065f

    mul-float v0, v0, v8

    float-to-int v0, v0

    .line 319
    const v4, 0x3cf5c28f    # 0.03f

    mul-float v4, v4, v8

    float-to-int v4, v4

    .line 320
    invoke-interface {v10}, Ljava/util/List;->size()I

    move-result v5

    mul-int v5, v5, v0

    invoke-interface {v10}, Ljava/util/List;->size()I

    move-result v14

    sub-int/2addr v14, v13

    mul-int v14, v14, v4

    add-int/2addr v5, v14

    .line 321
    sub-int/2addr v3, v5

    div-int/2addr v3, v12

    .line 322
    const v5, 0x3d75c28f    # 0.06f

    mul-float v5, v5, v8

    add-float/2addr v11, v5

    float-to-int v5, v11

    .line 324
    nop

    :goto_7
    invoke-interface {v10}, Ljava/util/List;->size()I

    move-result v11

    if-ge v6, v11, :cond_a

    .line 325
    invoke-interface {v10, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Landroid/graphics/drawable/Drawable;

    .line 326
    add-int v12, v0, v4

    mul-int v12, v12, v6

    add-int/2addr v12, v3

    .line 327
    add-int v13, v12, v0

    add-int v14, v5, v0

    invoke-virtual {v11, v12, v5, v13, v14}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 328
    invoke-virtual {v11, v2}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_3

    .line 324
    add-int/lit8 v6, v6, 0x1

    goto :goto_7

    .line 332
    :catch_3
    move-exception v0

    :cond_a
    nop

    .line 335
    const/high16 v0, 0x3f000000    # 0.5f

    mul-float v8, v8, v0

    .line 336
    const v0, 0x3f660aa6    # 0.8986f

    mul-float v7, v7, v0

    .line 337
    nop

    .line 339
    iget-object v0, v1, Lcom/androradar/walls6/AodActivity$AodView;->mFodPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 340
    iget-object v0, v1, Lcom/androradar/walls6/AodActivity$AodView;->mFodPaint:Landroid/graphics/Paint;

    const/high16 v3, 0x40400000    # 3.0f

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 341
    iget-object v0, v1, Lcom/androradar/walls6/AodActivity$AodView;->mFodPaint:Landroid/graphics/Paint;

    const v3, 0x40ffffff    # 7.9999995f

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 342
    iget-object v0, v1, Lcom/androradar/walls6/AodActivity$AodView;->mFodPaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v8, v7, v9, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 344
    iget-object v0, v1, Lcom/androradar/walls6/AodActivity$AodView;->mFodPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 345
    iget-object v0, v1, Lcom/androradar/walls6/AodActivity$AodView;->mFodPaint:Landroid/graphics/Paint;

    const v3, 0x15ffffff

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 346
    iget-object v0, v1, Lcom/androradar/walls6/AodActivity$AodView;->mFodPaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v8, v7, v9, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 347
    return-void

    .line 258
    :cond_b
    :goto_8
    return-void
.end method
