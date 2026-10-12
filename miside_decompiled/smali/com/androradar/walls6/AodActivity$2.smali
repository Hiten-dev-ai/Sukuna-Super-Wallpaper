.class Lcom/androradar/walls6/AodActivity$2;
.super Landroid/view/GestureDetector$SimpleOnGestureListener;
.source "AodActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/androradar/walls6/AodActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/androradar/walls6/AodActivity;


# direct methods
.method constructor <init>(Lcom/androradar/walls6/AodActivity;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 101
    iput-object p1, p0, Lcom/androradar/walls6/AodActivity$2;->this$0:Lcom/androradar/walls6/AodActivity;

    invoke-direct {p0}, Landroid/view/GestureDetector$SimpleOnGestureListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onDoubleTap(Landroid/view/MotionEvent;)Z
    .locals 1

    .line 114
    const-string p1, "AOD_DEBUG"

    const-string v0, "onDoubleTap: dismissing to lockscreen"

    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 115
    iget-object p1, p0, Lcom/androradar/walls6/AodActivity$2;->this$0:Lcom/androradar/walls6/AodActivity;

    invoke-virtual {p1}, Lcom/androradar/walls6/AodActivity;->dismissToLockscreen()V

    .line 116
    const/4 p1, 0x1

    return p1
.end method

.method public onSingleTapConfirmed(Landroid/view/MotionEvent;)Z
    .locals 1

    .line 104
    const-string p1, "AOD_DEBUG"

    const-string v0, "onSingleTapConfirmed: resetting 10s timer"

    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 105
    iget-object p1, p0, Lcom/androradar/walls6/AodActivity$2;->this$0:Lcom/androradar/walls6/AodActivity;

    invoke-static {p1}, Lcom/androradar/walls6/AodActivity;->access$000(Lcom/androradar/walls6/AodActivity;)V

    .line 106
    iget-object p1, p0, Lcom/androradar/walls6/AodActivity$2;->this$0:Lcom/androradar/walls6/AodActivity;

    invoke-static {p1}, Lcom/androradar/walls6/AodActivity;->access$100(Lcom/androradar/walls6/AodActivity;)Lcom/androradar/walls6/AodActivity$AodView;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 107
    iget-object p1, p0, Lcom/androradar/walls6/AodActivity$2;->this$0:Lcom/androradar/walls6/AodActivity;

    invoke-static {p1}, Lcom/androradar/walls6/AodActivity;->access$100(Lcom/androradar/walls6/AodActivity;)Lcom/androradar/walls6/AodActivity$AodView;

    move-result-object p1

    invoke-virtual {p1}, Lcom/androradar/walls6/AodActivity$AodView;->invalidate()V

    .line 109
    :cond_0
    const/4 p1, 0x1

    return p1
.end method
