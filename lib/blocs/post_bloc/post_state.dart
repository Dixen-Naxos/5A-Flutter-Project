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

  const PostState({
    this.posts,
    this.status = PostStatus.initial,
  });

  PostState copyWith({
    ListPosts? posts,
    PostStatus? status,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
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
    );
  }
}
