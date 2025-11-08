from fastapi import Query


def PaginationParams(
    skip: int = Query(default=0, ge=0, description="Number of records to skip"),
    limit: int = Query(
        default=20, ge=1, le=100, description="Maximum number of records to return"
    ),
):
    return {"skip": skip, "limit": limit}
