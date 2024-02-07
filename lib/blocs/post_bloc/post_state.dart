part of 'post_bloc.dart';

enum PostStatus {
  initial,
  loading,
  success,
  error,
}

class PostState {
  final ListPosts? posts;
  final PostStatus status;
  final bool scrollLoading;

  const PostState({
    this.posts,
    this.status = PostStatus.initial,
    this.scrollLoading = false,
  });

  PostState lockScrollLoading() {
    return PostState(
      posts: posts,
      status: status,
      scrollLoading: true,
    );
  }

  PostState copyWith({
    ListPosts? posts,
    PostStatus? status,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
      scrollLoading: false,
    );
  }

  PostState addPosts({
    ListPosts? posts,
    PostStatus? status,
  }) {
    ListPosts newList = ListPosts(
      itemsReceived: posts!.itemsReceived,
      curPage: posts.curPage,
      nextPage: posts.nextPage,
      prevPage: posts.prevPage,
      offset: posts.offset,
      itemsTotal: posts.itemsTotal,
      pageTotal: posts.pageTotal,
      items: this.posts!.items..addAll(posts.items),
    );

    return PostState(
      posts: newList,
      status: status ?? this.status,
      scrollLoading: false,
    );
  }
}
