.class final enum Lcom/androradar/walls6/VideoPlayer$StreamCondition;
.super Ljava/lang/Enum;
.source "VideoPlayer.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/androradar/walls6/VideoPlayer;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "StreamCondition"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/androradar/walls6/VideoPlayer$StreamCondition;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/androradar/walls6/VideoPlayer$StreamCondition;

.field public static final enum FINE:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

.field public static final enum NEEDS_LAZY_RESTART:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

.field public static final enum NEEDS_RESTART:Lcom/androradar/walls6/VideoPlayer$StreamCondition;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    new-instance v0, Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    const-string v1, "FINE"

    invoke-direct {v0, v1, v2}, Lcom/androradar/walls6/VideoPlayer$StreamCondition;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->FINE:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    new-instance v0, Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    const-string v1, "NEEDS_RESTART"

    invoke-direct {v0, v1, v3}, Lcom/androradar/walls6/VideoPlayer$StreamCondition;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->NEEDS_RESTART:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    new-instance v0, Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    const-string v1, "NEEDS_LAZY_RESTART"

    invoke-direct {v0, v1, v4}, Lcom/androradar/walls6/VideoPlayer$StreamCondition;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->NEEDS_LAZY_RESTART:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    const/4 v0, 0x3

    new-array v0, v0, [Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->FINE:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    aput-object v1, v0, v2

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->NEEDS_RESTART:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    aput-object v1, v0, v3

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->NEEDS_LAZY_RESTART:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    aput-object v1, v0, v4

    sput-object v0, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->$VALUES:[Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/androradar/walls6/VideoPlayer$StreamCondition;
    .locals 1

    const-class v0, Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    return-object v0
.end method

.method public static values()[Lcom/androradar/walls6/VideoPlayer$StreamCondition;
    .locals 1

    sget-object v0, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->$VALUES:[Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    invoke-virtual {v0}, [Lcom/androradar/walls6/VideoPlayer$StreamCondition;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    return-object v0
.end method
