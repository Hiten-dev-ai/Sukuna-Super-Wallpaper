.class public abstract Lcom/androradar/walls6/Renderable;
.super Ljava/lang/Object;
.source "Renderable.java"


# instance fields
.field private final mQuad:Lcom/androradar/walls6/IndexedQuad;

.field protected final mShader:Lcom/androradar/walls6/Shader;


# direct methods
.method public constructor <init>(Lcom/androradar/walls6/Shader;Lcom/androradar/walls6/IndexedQuad;)V
    .locals 0
    .param p1    # Lcom/androradar/walls6/Shader;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/androradar/walls6/IndexedQuad;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/androradar/walls6/Renderable;->mShader:Lcom/androradar/walls6/Shader;

    iput-object p2, p0, Lcom/androradar/walls6/Renderable;->mQuad:Lcom/androradar/walls6/IndexedQuad;

    return-void
.end method


# virtual methods
.method protected bind([F)V
    .locals 1

    iget-object v0, p0, Lcom/androradar/walls6/Renderable;->mShader:Lcom/androradar/walls6/Shader;

    invoke-virtual {v0, p1}, Lcom/androradar/walls6/Shader;->bind([F)V

    return-void
.end method

.method public render([F)V
    .locals 1

    invoke-virtual {p0, p1}, Lcom/androradar/walls6/Renderable;->bind([F)V

    iget-object v0, p0, Lcom/androradar/walls6/Renderable;->mQuad:Lcom/androradar/walls6/IndexedQuad;

    invoke-virtual {v0}, Lcom/androradar/walls6/IndexedQuad;->render()V

    iget-object v0, p0, Lcom/androradar/walls6/Renderable;->mShader:Lcom/androradar/walls6/Shader;

    invoke-virtual {v0}, Lcom/androradar/walls6/Shader;->unbind()V

    return-void
.end method
