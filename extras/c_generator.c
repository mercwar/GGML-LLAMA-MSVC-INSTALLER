#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define MEMORY_POOL_SIZE 1024 * 1024 // 1 MB Pool Size
#define ALIGNMENT 8
#define ALIGN(size) (((size) + (ALIGNMENT - 1)) & ~(ALIGNMENT - 1))

// Block header tracking structure
typedef struct BlockHeader {
    size_t size;               // Size of the block payload
    int is_free;               // Flag indicating if block is available
    struct BlockHeader* next;  // Pointer to the next sequential block
} BlockHeader;

static uint8_t memory_pool[MEMORY_POOL_SIZE];
static BlockHeader* free_list_head = NULL;

// Initial framework initialization layer
void initialize_allocator(void) {
    free_list_head = (BlockHeader*)memory_pool;
    free_list_head->size = MEMORY_POOL_SIZE - sizeof(BlockHeader);
    free_list_head->is_free = 1;
    free_list_head->next = NULL;
    
    printf("[AVIS-MEMORY] Pool initialized at base address: 0x%p\n", (void*)memory_pool);
}

// Custom allocation core logic
void* avis_malloc(size_t size) {
    if (size == 0) return NULL;
    
    size_t aligned_size = ALIGN(size);
    BlockHeader* current = free_list_head;
    
    // Lazy system initialization check
    if (current == NULL) {
        initialize_allocator();
        current = free_list_head;
    }
    
    while (current != NULL) {
        if (current->is_free && current->size >= aligned_size) {
            // Check if block can be cleanly split
            if (current->size >= aligned_size + sizeof(BlockHeader) + ALIGNMENT) {
                BlockHeader* next_block = (BlockHeader*)((uint8_t*)current + sizeof(BlockHeader) + aligned_size);
                next_block->size = current->size - aligned_size - sizeof(BlockHeader);
                next_block->is_free = 1;
                next_block->next = current->next;
                
                current->size = aligned_size;
                current->next = next_block;
            }
            
            current->is_free = 0;
            void* payload_ptr = (void*)((uint8_t*)current + sizeof(BlockHeader));
            
            // Calculate and print tracking offset relative to pool base memory address
            uintptr_t offset = (uintptr_t)payload_ptr - (uintptr_t)memory_pool;
            printf("🤖 Allocated %zu bytes at block offset: +0x%llX\n", aligned_size, (unsigned long long)offset);
            
            return payload_ptr;
        }
        current = current->next;
    }
    
    printf("❌ Allocation failure: Out of memory pool space for size %zu\n", size);
    return NULL;
}

// Custom block release sequence
void avis_free(void* ptr) {
    if (ptr == NULL) return;
    
    BlockHeader* block = (BlockHeader*)((uint8_t*)ptr - sizeof(BlockHeader));
    block->is_free = 1;
    
    uintptr_t offset = (uintptr_t)ptr - (uintptr_t)memory_pool;
    printf("🔓 Freed block at offset: +0x%llX\n", (unsigned long long)offset);
    
    // Defragmentation pass: Coalesce adjacent free blocks to prevent fragmentation leaks
    BlockHeader* current = free_list_head;
    while (current != NULL && current->next != NULL) {
        if (current->is_free && current->next->is_free) {
            current->size += sizeof(BlockHeader) + current->next->size;
            current->next = current->next->next;
        } else {
            current = current->next;
        }
    }
}

int main(int argc, char *argv[]) {
    (void)argc; (void)argv; // Suppress unused MSVC argument flags
    
    printf("============================================================\n");
    printf("         AVIS SYSTEM INTEGRATION - TEST EXECUTION           \n");
    printf("============================================================\n\n");
    
    initialize_allocator();
    
    void* track_a = avis_malloc(128);
    void* track_b = avis_malloc(512);
    void* track_c = avis_malloc(64);
    
    avis_free(track_b);
    void* track_d = avis_malloc(256);
    
    avis_free(track_a);
    avis_free(track_c);
    avis_free(track_d);
    
    printf("\n============================================================\n");
    printf("         MEMORY TRACKING SEQUENCE COMPLETED CLEAN           \n");
    printf("============================================================\n");
    return 0;
}
