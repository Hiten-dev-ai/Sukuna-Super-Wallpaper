.class public Lcom/androradar/walls6/AodNotificationListener;
.super Landroid/service/notification/NotificationListenerService;
.source "AodNotificationListener.java"


# static fields
.field private static sInstance:Lcom/androradar/walls6/AodNotificationListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Landroid/service/notification/NotificationListenerService;-><init>()V

    return-void
.end method

.method public static getActiveAlerts()Ljava/util/List;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroid/service/notification/StatusBarNotification;",
            ">;"
        }
    .end annotation

    .line 28
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 29
    sget-object v1, Lcom/androradar/walls6/AodNotificationListener;->sInstance:Lcom/androradar/walls6/AodNotificationListener;

    if-eqz v1, :cond_6

    .line 31
    :try_start_0
    invoke-virtual {v1}, Lcom/androradar/walls6/AodNotificationListener;->getActiveNotifications()[Landroid/service/notification/StatusBarNotification;

    move-result-object v1

    .line 32
    if-eqz v1, :cond_5

    .line 33
    array-length v2, v1

    const/4 v3, 0x0

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v2, :cond_5

    aget-object v5, v1, v4

    .line 34
    if-nez v5, :cond_0

    goto :goto_3

    .line 35
    :cond_0
    invoke-virtual {v5}, Landroid/service/notification/StatusBarNotification;->getNotification()Landroid/app/Notification;

    move-result-object v6

    .line 36
    if-nez v6, :cond_1

    goto :goto_3

    .line 39
    :cond_1
    iget v7, v6, Landroid/app/Notification;->flags:I

    and-int/lit8 v7, v7, 0x2

    const/4 v8, 0x1

    if-eqz v7, :cond_2

    const/4 v7, 0x1

    goto :goto_1

    :cond_2
    const/4 v7, 0x0

    .line 40
    :goto_1
    iget v6, v6, Landroid/app/Notification;->flags:I

    and-int/lit8 v6, v6, 0x40

    if-eqz v6, :cond_3

    goto :goto_2

    :cond_3
    const/4 v8, 0x0

    .line 41
    :goto_2
    if-nez v7, :cond_4

    if-nez v8, :cond_4

    .line 42
    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 33
    :cond_4
    :goto_3
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 48
    :cond_5
    goto :goto_4

    .line 46
    :catch_0
    move-exception v1

    .line 50
    :cond_6
    :goto_4
    return-object v0
.end method


# virtual methods
.method public onListenerConnected()V
    .locals 0

    .line 15
    invoke-super {p0}, Landroid/service/notification/NotificationListenerService;->onListenerConnected()V

    .line 16
    sput-object p0, Lcom/androradar/walls6/AodNotificationListener;->sInstance:Lcom/androradar/walls6/AodNotificationListener;

    .line 17
    return-void
.end method

.method public onListenerDisconnected()V
    .locals 1

    .line 21
    invoke-super {p0}, Landroid/service/notification/NotificationListenerService;->onListenerDisconnected()V

    .line 22
    sget-object v0, Lcom/androradar/walls6/AodNotificationListener;->sInstance:Lcom/androradar/walls6/AodNotificationListener;

    if-ne v0, p0, :cond_0

    .line 23
    const/4 v0, 0x0

    sput-object v0, Lcom/androradar/walls6/AodNotificationListener;->sInstance:Lcom/androradar/walls6/AodNotificationListener;

    .line 25
    :cond_0
    return-void
.end method
